#!/usr/bin/env bash
#
# rdirsync.sh — Bidirectional folder sync between local (macOS) and remote (Linux)
#
# Watches for file changes on both sides and syncs automatically using rsync.
# Local side uses fswatch (macOS), remote side uses inotifywait (Linux).
#
# ============================================================================
#  PREREQUISITES
# ============================================================================
#
#  Local machine (macOS):
#  ----------------------
#  1. Homebrew (package manager):
#       /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
#  2. fswatch (filesystem watcher for macOS):
#       brew install fswatch
#
#  3. rsync (file sync tool — macOS ships with an old version, upgrade it):
#       brew install rsync
#
#  4. SSH key-based auth (recommended, avoids password prompts during sync):
#       # Generate a key if you don't have one:
#       ssh-keygen -t ed25519 -C "rdirsync"
#       # Copy it to the remote machine:
#       ssh-copy-id user@remote-host
#       # Verify passwordless login works:
#       ssh user@remote-host "echo ok"
#
#  Remote machine (Linux):
#  -----------------------
#  1. inotify-tools (filesystem watcher for Linux):
#       Ubuntu/Debian:  sudo apt update && sudo apt install -y inotify-tools
#       CentOS/RHEL:    sudo yum install -y inotify-tools
#       Fedora:         sudo dnf install -y inotify-tools
#       Arch:           sudo pacman -S inotify-tools
#
#  2. rsync (usually pre-installed, if not):
#       Ubuntu/Debian:  sudo apt install -y rsync
#       CentOS/RHEL:    sudo yum install -y rsync
#
#  3. (Optional) Increase inotify watch limit for large directories:
#       # Check current limit:
#       cat /proc/sys/fs/inotify/max_user_watches
#       # Increase temporarily:
#       sudo sysctl fs.inotify.max_user_watches=524288
#       # Increase permanently:
#       echo "fs.inotify.max_user_watches=524288" | sudo tee -a /etc/sysctl.conf
#       sudo sysctl -p
#
# ============================================================================
#  USAGE
# ============================================================================
#
#  rdirsync.sh <local_folder> <remote_host> <remote_folder> [options]
#
#  Arguments:
#    local_folder    Path to the local folder on macOS
#    remote_host     SSH hostname, alias, or user@host for the remote machine
#    remote_folder   Absolute path to the folder on the remote machine
#
#  Options:
#    --push                  Local→Remote only (watch local, push changes to remote)
#    --pull                  Remote→Local only (watch remote, pull changes to local)
#    --both                  Bidirectional sync (default if neither --push nor --pull)
#    -k, --key PATH          Path to SSH private key
#    -n, --no-initial-sync   Skip the initial full sync on startup
#    -h, --help              Show this help message
#
# ============================================================================
#  EXAMPLES
# ============================================================================
#
#  Bidirectional sync (default):
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp
#
#  Push only — local changes sync to remote:
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp --push
#
#  Pull only — remote changes sync to local:
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp --pull
#
#  Both directions (explicit, same as default):
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp --both
#
#  Push + pull flags can be combined (same as --both):
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp --push --pull
#
#  With a specific SSH key:
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp -k ~/.ssh/id_rsa
#
#  Skip initial sync (only sync new changes going forward):
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp --pull --no-initial-sync
#
#  Combine options:
#    rdirsync.sh ~/projects/myapp devbox /home/user/myapp --push -k ~/.ssh/id_rsa -n
#
# ============================================================================
#  HOW IT WORKS
# ============================================================================
#
#  1. INITIAL SYNC (on startup, unless --no-initial-sync):
#     - Pulls files from remote that don't exist locally (--ignore-existing)
#     - Pushes all local files to remote (local wins on conflicts)
#     - This ensures both sides start in a consistent state
#
#  2. LOCAL WATCHER (fswatch on macOS):
#     - Recursively monitors local_folder for file create/modify/delete
#     - On change: waits 3s (debounce), then rsync pushes to remote
#     - Prints a summary of added/modified/deleted files after each sync
#
#  3. REMOTE POLLER (rsync dry-run over SSH):
#     - Polls the remote every 5s using rsync --dry-run to detect changes
#     - Works on any filesystem including NFS (inotify doesn't work on NFS)
#     - Prints a summary of added/modified/deleted files after each sync
#
#  4. CONFLICT HANDLING:
#     - Last write wins (rsync overwrites the older copy)
#     - Simultaneous edits on both sides: the side that syncs last wins
#
#  5. EXCLUDED BY DEFAULT:
#     .git/  .DS_Store  *.swp  __pycache__/
#     (Edit RSYNC_EXCLUDES below to customize exclusions)
#
# ============================================================================
#  STOPPING
# ============================================================================
#
#  Press Ctrl+C — kills all child processes including remote inotifywait.
#
#  If orphans remain (script crashed), run:
#    pkill -f rdirsync.sh
#    pkill -f 'fswatch.*<your_folder>'
#    ssh <remote> "pkill -f 'inotifywait.*<remote_folder>'"
#
# ============================================================================
#  TROUBLESHOOTING
# ============================================================================
#
#  "fswatch not found"
#    → brew install fswatch
#
#  "inotifywait not found on remote"
#    → SSH into remote and install inotify-tools (see Prerequisites above)
#
#  "Cannot SSH to remote"
#    → Verify: ssh <remote_host> "echo ok"
#    → Check ~/.ssh/config for host alias, or use user@ip format
#    → Ensure SSH key is loaded: ssh-add -l
#
#  "No space left on device" (inotify)
#    → Increase inotify watch limit (see Prerequisites step 3)
#
#  Sync seems slow or misses changes
#    → Reduce COOLDOWN below (default 3s) for faster reaction
#    → Increase for less CPU usage on busy directories
#
# ============================================================================

set -uo pipefail

# --- Configuration ---
COOLDOWN=3          # seconds debounce after detecting a change
GRACE=10            # seconds to ignore echo-back after a sync completes
RSYNC_EXCLUDES="--exclude=.git --exclude=.DS_Store --exclude='*.swp' --exclude='__pycache__'"
# -i = itemize changes (shows what changed), -az = archive+compress
RSYNC_OPTS="-iaz --delete $RSYNC_EXCLUDES"

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
DIM='\033[2m'
NC='\033[0m'

log()  { echo -e "${CYAN}[rdirsync $(date +%H:%M:%S)]${NC} $*"; }
ok()   { echo -e "${GREEN}[rdirsync $(date +%H:%M:%S)]${NC} $*"; }
warn() { echo -e "${YELLOW}[rdirsync $(date +%H:%M:%S)]${NC} $*"; }
err()  { echo -e "${RED}[rdirsync $(date +%H:%M:%S)]${NC} $*" >&2; }

# Print a human-readable summary of rsync -i output
# rsync -i format: YXcstpoguax path
#   Y = update type: < sent, > received, c local change, * message
#   X = file type: f file, d directory, L symlink
print_changes() {
    local output="$1"
    local direction="$2"  # "pushed" or "pulled"
    local added=() modified=() deleted=()

    while IFS= read -r line; do
        [[ -z "$line" ]] && continue
        # Skip directory entries and summary lines
        [[ "$line" =~ ^\.d ]] && continue
        [[ "$line" =~ ^[[:space:]] ]] && continue

        local flags="${line:0:11}"
        local path="${line:12}"
        [[ -z "$path" ]] && continue

        if [[ "$line" == *deleting* ]]; then
            deleted+=("$path")
        elif [[ "${flags:0:1}" == ">" || "${flags:0:1}" == "<" ]]; then
            if [[ "${flags:2:1}" == "+" ]]; then
                added+=("$path")
            else
                modified+=("$path")
            fi
        elif [[ "${flags:0:2}" == "cd" ]]; then
            added+=("$path")
        fi
    done <<< "$output"

    local total=$(( ${#added[@]} + ${#modified[@]} + ${#deleted[@]} ))
    if [[ $total -eq 0 ]]; then
        ok "  No changes."
        return
    fi

    if [[ ${#added[@]} -gt 0 ]]; then
        ok "  ${GREEN}+${NC} ${#added[@]} added:"
        for f in "${added[@]}"; do
            echo -e "    ${GREEN}+ ${f}${NC}"
        done
    fi
    if [[ ${#modified[@]} -gt 0 ]]; then
        ok "  ${CYAN}~${NC} ${#modified[@]} modified:"
        for f in "${modified[@]}"; do
            echo -e "    ${CYAN}~ ${f}${NC}"
        done
    fi
    if [[ ${#deleted[@]} -gt 0 ]]; then
        ok "  ${RED}-${NC} ${#deleted[@]} deleted:"
        for f in "${deleted[@]}"; do
            echo -e "    ${RED}- ${f}${NC}"
        done
    fi
}

usage() {
    echo "Usage: $(basename "$0") <local_folder> <remote_host> <remote_folder> [options]"
    echo ""
    echo "Arguments:"
    echo "  local_folder   Path to the local folder (macOS)"
    echo "  remote_host    SSH hostname or user@host for the remote machine"
    echo "  remote_folder  Path to the folder on the remote machine"
    echo ""
    echo "Sync direction:"
    echo "  --push                 Local→Remote only (watch local, push to remote)"
    echo "  --pull                 Remote→Local only (watch remote, pull to local)"
    echo "  --both                 Bidirectional (default)"
    echo ""
    echo "Options:"
    echo "  -k, --key <path>       Path to SSH private key"
    echo "  -n, --no-initial-sync  Skip the initial full sync on startup"
    echo "  -h, --help             Show this help message"
    echo ""
    echo "Examples:"
    echo "  $(basename "$0") ~/code/project devbox /home/user/project"
    echo "  $(basename "$0") ~/code/project devbox /home/user/project --push"
    echo "  $(basename "$0") ~/code/project devbox /home/user/project --pull -n"
    exit 1
}

# --- Argument parsing ---
if [[ $# -lt 3 ]]; then
    usage
fi

LOCAL_DIR="${1%/}"
REMOTE_HOST="$2"
REMOTE_DIR="${3%/}"
shift 3

SSH_KEY=""
NO_INITIAL_SYNC=false
DO_PUSH=false
DO_PULL=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --push)
            DO_PUSH=true
            shift
            ;;
        --pull)
            DO_PULL=true
            shift
            ;;
        --both)
            DO_PUSH=true
            DO_PULL=true
            shift
            ;;
        -k|--key)
            SSH_KEY="$2"
            shift 2
            ;;
        -n|--no-initial-sync)
            NO_INITIAL_SYNC=true
            shift
            ;;
        -h|--help)
            usage
            ;;
        *)
            err "Unknown option: $1"
            usage
            ;;
    esac
done

# Default: both directions if neither --push nor --pull specified
if [[ "$DO_PUSH" == false && "$DO_PULL" == false ]]; then
    DO_PUSH=true
    DO_PULL=true
fi

if [[ ! -d "$LOCAL_DIR" ]]; then
    err "Local directory does not exist: $LOCAL_DIR"
    exit 1
fi

SSH_OPTS="-o ConnectTimeout=5 -o StrictHostKeyChecking=accept-new"
if [[ -n "$SSH_KEY" ]]; then
    SSH_OPTS="$SSH_OPTS -i $SSH_KEY"
fi

# Resolve REMOTE_DIR to an absolute path on the remote machine.
if [[ "$REMOTE_DIR" == /* ]]; then
    # Already absolute — just verify it exists
    log "Verifying remote path: $REMOTE_DIR"
    if ! ssh $SSH_OPTS "$REMOTE_HOST" "test -d '$REMOTE_DIR'" 2>/dev/null; then
        # Directory might not exist yet — create it
        log "Creating remote directory: $REMOTE_DIR"
        ssh $SSH_OPTS "$REMOTE_HOST" "mkdir -p '$REMOTE_DIR'" 2>/dev/null || true
    fi
else
    # Relative or tilde path — resolve via cd+pwd on remote
    log "Resolving remote path: $REMOTE_DIR"
    RESOLVED=$(ssh $SSH_OPTS "$REMOTE_HOST" "cd $REMOTE_DIR 2>/dev/null && pwd" 2>/dev/null || true)
    if [[ -n "$RESOLVED" ]]; then
        REMOTE_DIR="$RESOLVED"
        log "Resolved remote path: $REMOTE_DIR"
    else
        err "Remote directory does not exist: $REMOTE_DIR"
        exit 1
    fi
fi

RSYNC_SSH="ssh $SSH_OPTS"

# --- Grace period tracking via files (shared across subshells) ---
PUSH_STAMP="/tmp/rdirsync_push_$$"
PULL_STAMP="/tmp/rdirsync_pull_$$"
echo "0" > "$PUSH_STAMP"
echo "0" > "$PULL_STAMP"

now_epoch() { date +%s; }

in_grace() {
    local stamp_file="$1"
    local last now elapsed
    last=$(cat "$stamp_file" 2>/dev/null || echo 0)
    now=$(now_epoch)
    elapsed=$((now - last))
    [[ $elapsed -lt $GRACE ]]
}

# --- Cleanup on exit ---
CHILDREN=()
add_child() { CHILDREN+=("$1"); }

cleanup() {
    log "Shutting down..."

    # Kill all tracked child PIDs
    for pid in "${CHILDREN[@]}"; do
        kill "$pid" 2>/dev/null || true
    done

    # Safety net: kill any remaining children of this script
    pkill -P $$ 2>/dev/null || true

    # No remote inotifywait to kill — pull mode uses polling

    # Clean up temp files
    rm -f "$PUSH_STAMP" "$PULL_STAMP"

    wait 2>/dev/null || true
    ok "Stopped."
    exit 0
}
trap cleanup INT TERM EXIT

# --- Preflight checks ---
log "Checking prerequisites..."

if [[ "$DO_PUSH" == true ]]; then
    if ! command -v fswatch &>/dev/null; then
        err "fswatch not found. Install with: brew install fswatch"
        exit 1
    fi
fi

if ! command -v rsync &>/dev/null; then
    err "rsync not found. Install with: brew install rsync"
    exit 1
fi

log "Testing SSH connection to $REMOTE_HOST..."
if ! ssh $SSH_OPTS "$REMOTE_HOST" "echo ok" &>/dev/null; then
    err "Cannot SSH to $REMOTE_HOST. Check connectivity and credentials."
    exit 1
fi

    # Pull mode uses rsync polling — no inotifywait needed (works on NFS too)

ok "All checks passed."

# --- Initial sync ---
if [[ "$NO_INITIAL_SYNC" == true ]]; then
    warn "Skipping initial sync (--no-initial-sync)."
else
    if [[ "$DO_PUSH" == true && "$DO_PULL" == true ]]; then
        log "Performing initial bidirectional sync..."
        rsync $RSYNC_OPTS --ignore-existing -e "$RSYNC_SSH" \
            "$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR/" 2>/dev/null || true
        rsync $RSYNC_OPTS -e "$RSYNC_SSH" \
            "$LOCAL_DIR/" "$REMOTE_HOST:$REMOTE_DIR/" 2>/dev/null || true
    elif [[ "$DO_PUSH" == true ]]; then
        log "Performing initial sync LOCAL → REMOTE..."
        rsync $RSYNC_OPTS -e "$RSYNC_SSH" \
            "$LOCAL_DIR/" "$REMOTE_HOST:$REMOTE_DIR/" 2>/dev/null || true
    else
        log "Performing initial sync REMOTE → LOCAL..."
        rsync $RSYNC_OPTS -e "$RSYNC_SSH" \
            "$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR/" 2>/dev/null || true
    fi
    ok "Initial sync complete."
fi

# Set grace timestamps so watchers ignore initial-sync echo.
# Only set stamps for directions that are active — otherwise the grace
# check falsely suppresses events in single-direction modes.
if [[ "$DO_PUSH" == true ]]; then
    now_epoch > "$PUSH_STAMP"
fi
if [[ "$DO_PULL" == true ]]; then
    now_epoch > "$PULL_STAMP"
fi

LOCAL_PID=""
REMOTE_PID=""

# --- Local watcher: fswatch → rsync push (if --push) ---
if [[ "$DO_PUSH" == true ]]; then
    log "Starting local watcher on $LOCAL_DIR..."
    (
        set +euo pipefail 2>/dev/null
        fswatch -r -l "$COOLDOWN" \
            --exclude='\.git' --exclude='\.DS_Store' --exclude='\.swp$' \
            --exclude='__pycache__' \
            "$LOCAL_DIR" | \
        while read -r _event; do
            # Drain buffered events
            while read -r -t 1 _drain 2>/dev/null; do :; done

            # Skip echo-back from a recent remote→local sync
            if in_grace "$PULL_STAMP"; then
                continue
            fi

            log "Syncing LOCAL → REMOTE..."
            output=$(rsync $RSYNC_OPTS -e "$RSYNC_SSH" \
                "$LOCAL_DIR/" "$REMOTE_HOST:$REMOTE_DIR/" 2>/dev/null || true)
            ok "LOCAL → REMOTE done."
            print_changes "$output" "pushed"
            now_epoch > "$PUSH_STAMP"
        done
    ) &
    add_child $!
    LOCAL_PID=$!
fi

# --- Remote watcher: poll for changes → rsync pull (if --pull) ---
# inotifywait does not work on NFS mounts, so we poll using rsync --dry-run
# to detect changes on the remote side.
POLL_INTERVAL=5  # seconds between polls
if [[ "$DO_PULL" == true ]]; then
    log "Starting remote poller on $REMOTE_HOST:$REMOTE_DIR (every ${POLL_INTERVAL}s)..."
    (
        set +euo pipefail 2>/dev/null
        while true; do
            sleep "$POLL_INTERVAL"

            # Skip echo-back from a recent local→remote sync
            if in_grace "$PUSH_STAMP"; then
                continue
            fi

            # Dry-run rsync to check if remote has changes
            changes=$(rsync $RSYNC_OPTS --dry-run -e "$RSYNC_SSH" \
                "$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR/" 2>/dev/null || true)

            # Skip if no changes detected
            if [[ -z "$changes" ]]; then
                continue
            fi

            log "Syncing REMOTE → LOCAL..."
            output=$(rsync $RSYNC_OPTS -e "$RSYNC_SSH" \
                "$REMOTE_HOST:$REMOTE_DIR/" "$LOCAL_DIR/" 2>/dev/null || true)
            ok "REMOTE → LOCAL done."
            print_changes "$output" "pulled"
            now_epoch > "$PULL_STAMP"
        done
    ) &
    add_child $!
    REMOTE_PID=$!
fi

# --- Determine mode label ---
if [[ "$DO_PUSH" == true && "$DO_PULL" == true ]]; then
    MODE="BIDIRECTIONAL (push + pull)"
elif [[ "$DO_PUSH" == true ]]; then
    MODE="PUSH ONLY (local → remote)"
else
    MODE="PULL ONLY (remote → local)"
fi

# --- Running ---
echo ""
ok "=========================================="
ok " Sync is running: $MODE"
ok "   Local:  $LOCAL_DIR"
ok "   Remote: $REMOTE_HOST:$REMOTE_DIR"
ok "   Press Ctrl+C to stop"
ok "=========================================="
echo ""

# Wait until a watcher dies (bash 3.2 compatible — no wait -n)
while true; do
    if [[ -n "$LOCAL_PID" ]] && ! kill -0 "$LOCAL_PID" 2>/dev/null; then
        warn "Local watcher exited."
        break
    fi
    if [[ -n "$REMOTE_PID" ]] && ! kill -0 "$REMOTE_PID" 2>/dev/null; then
        warn "Remote watcher exited."
        break
    fi
    sleep 2
done
