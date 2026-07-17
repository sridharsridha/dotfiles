#!/usr/bin/env python3
# Copyright (c) 2024. All rights reserved.
# Confidential and Proprietary.

# Required packages:
#   pexpect
#
# Install packages if missing:
#   pip3 install pexpect

from shutil import which
import os
import pexpect, struct, fcntl, termios, signal, sys
import shlex
import subprocess
import tempfile
import argparse

# Credit https://github.com/nk412/pyfzf/blob/master/pyfzf/pyfzf.py
FZF_URL = "https://github.com/junegunn/fzf"
class FzfPrompt:
    def __init__(self, exec_path=None):
        if exec_path:
            self.exec_path = exec_path
        elif not which("fzf") and not exec_path:
            raise SystemError(f"Cannot find 'fzf' installed on PATH. ({FZF_URL})")
        else:
            self.exec_path = "fzf"

    def prompt(self, choices=None, fzf_options="", delimiter="\n"):
        """choices can be a string with newlines or a list of strings,
        fzf_options are fzf options to change its behaviour.
        """
        # convert a list to a string [ 1, 2, 3 ] => "1\n2\n3"
        if isinstance(choices, str):
            choices_str = choices
        else:
            choices_str = delimiter.join(map(str, choices))
        selection = []

        with tempfile.NamedTemporaryFile(delete=False) as input_file:
            with tempfile.NamedTemporaryFile(delete=False) as output_file:
                # Create a temp file with list entries as lines
                input_file.write(choices_str.encode("utf-8"))
                input_file.flush()

        # Invoke fzf externally and write to output file
        os.system(
            f"{self.exec_path} {fzf_options} "
            f'< "{input_file.name}" > "{output_file.name}"'
        )

        # get selected options
        with open(output_file.name, encoding="utf-8") as f:
            for line in f:
                selection.append(line.strip("\n"))

        os.unlink(input_file.name)
        os.unlink(output_file.name)

        return selection


# Taken from pexpect documentation related to windowresize.
class TerminalSizer:
    def __init__(self, process):
        self.process = process

    def get_size(self):
        """Return tuple with rows, columns"""
        s = struct.pack("HHHH", 0, 0, 0, 0)
        a = struct.unpack(
            "hhhh", fcntl.ioctl(sys.stdout.fileno(), termios.TIOCGWINSZ, s)
        )
        return a[0], a[1]

    def __enter__(self):
        self.process.setwinsize(*self.get_size())
        signal.signal(signal.SIGWINCH, self)
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        signal.signal(signal.SIGWINCH, signal.SIG_DFL)

    def __call__(self, sig, data):
        if not self.process.closed:
            self.process.setwinsize(*self.get_size())

def get_workspaces(server, port=None, retry_login=True, login_cmd="ssh"):
    portCmd = ""
    if port:
        portCmd = f"-p {port}"
    cmd = f"ssh {portCmd} {server} -t a4c ps -N"
    
    # Added stderr=subprocess.PIPE to capture the error stream properly
    p = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    (output, err) = p.communicate()
    p_status = p.wait()
    
    if p_status != 0:
        # Safely decode the error message now that stderr is captured
        err_msg = err.decode('utf-8', errors='ignore')
        
        # Check if the error is related to an expired session or permission denied
        if retry_login and ("Auth session has expired" in err_msg or "Permission denied" in err_msg):
            # Create a user-specific lock file in /tmp to prevent permission conflicts
            lock_file_path = f"/tmp/ssh_login_{os.getuid()}.lock"
            
            with open(lock_file_path, "w") as lock_file:
                # fcntl.LOCK_EX blocks until the lock is acquired. 
                # If another script instance is logging in, this script waits here.
                fcntl.flock(lock_file, fcntl.LOCK_EX)
                try:
                    # DOUBLE-CHECK: Now that we have the lock, test the connection again. 
                    # If the previous script instance successfully logged in, this will pass and we can skip the prompt.
                    test_p = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                    _, test_err = test_p.communicate()
                    
                    if test_p.wait() != 0:
                        test_err_msg = test_err.decode('utf-8', errors='ignore')
                        if "Auth session has expired" in test_err_msg or "Permission denied" in test_err_msg:
                            print(f"SSH session expired. Launching '{login_cmd} login'...")
                            
                            # Run the login command interactively so you can enter your credentials/MFA
                            login_status = subprocess.call([login_cmd, "login"])
                            
                            if login_status != 0:
                                print("Authentication failed or was cancelled.")
                                return list()
                            else:
                                print("Login successful.")
                finally:
                    # Ensure the lock is ALWAYS released, even if the user hits Ctrl+C
                    fcntl.flock(lock_file, fcntl.LOCK_UN)

            print("Retrying connection...")
            # Recursively call the function once, but disable retry to avoid infinite loops
            return get_workspaces(server, port, retry_login=False, login_cmd=login_cmd)
                
        # If it's a different error or the retry already failed, print and return empty
        print(f"{cmd} failed with errcode {p_status}\n{err_msg}")
        return list()
        
    output = output.decode('utf-8', errors='ignore').strip()
    if not output:
        return []
    output = output.split("\n")
    return output


def setupArguments():
    parser = argparse.ArgumentParser(
        description=(
            "Makes life easier to login to userspace and containers. "
            "Passwordless login needs to be setup for userserver. "
            "Using Ctrl+C at FZF prompt will login to userserver"
        ),
    )
    parser.add_argument(
        "server",
        help=(
            "Userserver to connect too, if the username of host is different "
            "from userserver, then use <userserver_username>@<server>"
        ),
    )
    parser.add_argument(
        "--app",
        "-a",
        default="mosh",
        help="Remote terminal application to use to login to userserver",
    )
    parser.add_argument(
        "--login-cmd",
        "-l",
        default="ssh",
        help="Command to use to trigger authentication when session expires",
    )
    parser.add_argument(
        "--fzf-options",
        "-f",
        default="--cycle --height=40% --layout=reverse",
        help="FZF command options to use when listing containers",
    )
    parser.add_argument(
        "--run-cmd",
        "-r",
        default="tmux a || tmux new -s DEFAULT",
        help="Command to run after logging into userserver or container",
    )
    parser.add_argument(
        "--remote-port",
        "-p",
        default=None,
        help="Port to connect to on remote host",
    )
    return parser.parse_args()


if __name__ == "__main__":
    args = setupArguments()

    # Get the list of all containers in the userserver.
    all_workspaces = get_workspaces(args.server, args.remote_port, login_cmd=args.login_cmd)

    # Use FZF to prompt to select a container or Ctrl+C to not select anything.
    # If none selected default to userserver.
    fzf = FzfPrompt()
    workspace = fzf.prompt(all_workspaces, args.fzf_options)
    cmd = f"{args.app} {args.server}"
    child = pexpect.spawn(cmd)
    if workspace:
        # FZF return empty list when not selected or a list of selected entries.
        ws = workspace[0].split(" ")[0]
        cmd = f"a4c shell {ws}"
        child.sendline(cmd)
    with TerminalSizer(child):
        # if we already inside a tmux session do not open a new one.
        if "TMUX" not in os.environ:
            child.sendline(args.run_cmd)
        child.interact()

    print("Bye Bye!!!")
