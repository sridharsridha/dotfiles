#!/usr/bin/env python3
"""
This script manages the installation and setup of dotfiles and a macOS development environment.

Usage:
  # Install all dotfiles (default action)
  python3 install.py

  # Install dotfiles for specific applications
  python3 install.py -i zsh tmux

  # Install all dotfiles
  python3 install.py -i

  # Delete dotfiles for specific applications
  python3 install.py -d git

  # Delete all dotfiles
  python3 install.py -d

  # Run the full macOS setup
  python3 install.py --setup-macos

  # See what commands would be run without executing them
  python3 install.py -i zsh --dry-run
"""

import argparse
import shutil
import subprocess
from pathlib import Path
from typing import Dict, List, Callable, Any

try:
   import yaml
except ImportError:
   print( "PyYAML is not installed. Please install it with: pip install pyyaml" )
   exit( 1 )

# --- Color and Emoji Definitions for Pretty Printing ---
class Color:
   """ANSI color codes"""
   RESET = "\033[0m"
   BOLD = "\033[1m"
   RED = "\033[31m"
   GREEN = "\033[32m"
   YELLOW = "\033[33m"
   BLUE = "\033[34m"
   MAGENTA = "\033[35m"
   CYAN = "\033[36m"

class Printer:
   """Handles printing colorful and formatted output."""

   def print_info( self, message: str ):
      print( f"{Color.CYAN}ℹ️  {message}{Color.RESET}" )

   def print_success( self, message: str ):
      print( f"{Color.GREEN}✅ {message}{Color.RESET}" )

   def print_warning( self, message: str ):
      print( f"{Color.YELLOW}⚠️  {message}{Color.RESET}" )

   def print_header( self, message: str ):
      print( f"\n{Color.BOLD}{Color.MAGENTA}🚀 {message} 🚀{Color.RESET}" )

   def print_dry_run( self, message: str ):
      print( f"{Color.YELLOW}DRY RUN: {message}{Color.RESET}" )

class MacOSSetup( Printer ):
   """Handles the initial setup of a macOS environment."""

   def __init__( self, config: Dict[ str, Any ], dry_run: bool = False ):
      self.dry_run = dry_run
      self.home = Path.home()
      self.config = config
      self.brew_packages = self.config.get( "brew_packages", [] )
      self.cask_packages = self.config.get( "cask_packages", [] )
      self.npm_packages = self.config.get( "npm_packages", [] )

   def run_command( self, command: List[ str ], check: bool = True ):
      if self.dry_run:
         self.print_dry_run( f"Would run: {' '.join(command)}" )
      else:
         subprocess.run( command, check=check )

   def cmd_exists( self, cmd: str ) -> bool:
      return shutil.which( cmd ) is not None

   def run( self ):
      self.print_header( "Setting up macOS" )
      self.install_homebrew()
      self.setup_ssh()
      self.authenticate_github()
      self.install_packages()
      self.print_success( "macOS setup complete!" )

   def install_homebrew( self ):
      if not self.cmd_exists( "brew" ):
         self.print_info( "Installing Homebrew..." )
         self.run_command( [
            '/bin/bash', '-c',
            '"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
         ] )
      else:
         self.print_info( "Homebrew already installed." )

   def setup_ssh( self ):
      ssh_key_path = self.home / ".ssh/id_ed25519"
      if not ssh_key_path.exists():
         self.print_info( "Creating SSH key..." )
         self.run_command( [
            "ssh-keygen", "-t", "ed25519", "-C", "sridha.in@gmail.com", "-f",
            str( ssh_key_path ), "-N", ""
         ],
                           check=False )
      else:
         self.print_info( "SSH key already exists." )

      ssh_config_path = self.home / ".ssh/config"
      ssh_config_path.parent.mkdir( parents=True, exist_ok=True )
      config_text = "\nHost github.com\n  AddKeysToAgent yes\n  UseKeychain yes\n  IdentityFile ~/.ssh/id_ed25519\n"
      if not ssh_config_path.exists(
      ) or "Host github.com" not in ssh_config_path.read_text():
         self.print_info( "Configuring SSH for GitHub..." )
         if self.dry_run:
            self.print_dry_run( f"Would append to {ssh_config_path}" )
         else:
            with ssh_config_path.open( "a" ) as f:
               f.write( config_text )
      else:
         self.print_info( "SSH for GitHub already configured." )

      self.print_info( "Adding SSH key to keychain..." )
      self.run_command( [ "ssh-add", "--apple-use-keychain",
                          str( ssh_key_path ) ],
                        check=False )

   def authenticate_github( self ):
      self.print_info( "Please login to GitHub CLI..." )
      self.run_command( [ "gh", "auth", "login" ], check=False )
      self.print_info( "Testing GitHub SSH connection..." )
      self.run_command( [ "ssh", "-T", "git@github.com" ], check=False )

   def install_packages( self ):
      self.print_info( "Installing Homebrew packages..." )
      if self.brew_packages:
         self.run_command( [ "brew", "install" ] + self.brew_packages )

      self.print_info( "Installing Homebrew casks..." )
      if self.cask_packages:
         self.run_command( [ "brew", "install", "--cask" ] + self.cask_packages )

      self.print_info( "Installing global npm packages..." )
      if self.npm_packages:
         self.run_command( [ "npm", "i", "-g" ] + self.npm_packages )

class DotfilesManager( Printer ):
   """Manages the installation and deletion of dotfiles."""

   def __init__( self, config_path: Path, dry_run: bool = False ):
      self.dry_run = dry_run
      self.home = Path.home()
      self.pwd = Path.cwd()
      self.config_path = config_path
      self.config = self.load_config()
      self.apps_config = self.config.get( "apps", {} )
      self.macos_setup_config = self.config.get( "macos_setup", {} )

   def load_config( self ) -> Dict[ str, Any ]:
      with open( self.config_path, 'r' ) as f:
         return yaml.safe_load( f )

   def resolve_path( self, path_str: str ) -> Path:
      return Path(
         path_str.replace( "$HOME", str( self.home ) ).replace(
            "$CONFIG",
            str( self.home / ".config" ) ).replace( "$PWD", str( self.pwd ) ) )

   def run_command( self, command: List[ Any ] ):
      str_command = [ str( c ) for c in command ]
      if self.dry_run:
         self.print_dry_run( f"Would run: {' '.join(str_command)}" )
      else:
         subprocess.run( str_command, check=True )

   def cmd_exists( self, cmd: str ) -> bool:
      return shutil.which( cmd ) is not None

   def create_symlink( self, source: str, target: str ):
      source_path = self.resolve_path( source )
      target_path = self.resolve_path( target )

      if not source_path.exists():
         self.print_warning( f"Source {source_path} not found, skipping." )
         return

      if not self.dry_run:
         target_path.parent.mkdir( parents=True, exist_ok=True )

      if self.dry_run:
         self.print_dry_run(
            f"Would create parent directory for {target_path} if it doesn't exist." )
         if target_path.exists() or target_path.is_symlink():
            self.print_dry_run(
               f"Would move existing {target_path.name} to {target_path.name}.bkp" )
         self.print_dry_run( f"Would link {source_path} to {target_path}" )
      else:
         if target_path.exists() or target_path.is_symlink():
            self.print_warning(
               f"Moving existing {target_path.name} to {target_path.name}.bkp" )
            target_path.rename( f"{target_path}.bkp" )
         self.print_info( f"Linking {source_path.name} to {target_path}" )
         target_path.symlink_to( source_path )

   def remove_symlink( self, target: str ):
      target_path = self.resolve_path( target )
      if not target_path.is_symlink():
         self.print_warning( f"Symlink {target_path.name} not found, skipping." )
         return

      if self.dry_run:
         self.print_dry_run( f"Would delete symlink: {target_path.name}" )
         old_target = Path( f"{target_path}.bkp" )
         if old_target.exists():
            self.print_dry_run( f"Would restore {old_target.name}" )
      else:
         self.print_info( f"Deleting symlink: {target_path.name}" )
         target_path.unlink()
         old_target = Path( f"{target_path}.bkp" )
         if old_target.exists():
            self.print_info( f"Restoring {old_target.name}" )
            old_target.rename( target_path )

   def ensure_dir( self, path_str: str ):
      path = self.resolve_path( path_str )
      if self.dry_run:
         self.print_dry_run( f"Would create directory {path} if it doesn't exist." )
      else:
         path.mkdir( parents=True, exist_ok=True )

   def install_fonts( self ):
      font_dir = self.resolve_path( "$HOME/Library/Fonts" )
      fonts_source_dir = self.resolve_path( "$PWD/fonts" )
      if not font_dir.is_dir():
         self.print_warning(
            f"Font directory '{font_dir}' not found. Skipping font installation." )
         return

      for font_file in fonts_source_dir.rglob( "*.ttf" ):
         target_font = font_dir / font_file.name
         if not target_font.exists():
            if self.dry_run:
               self.print_dry_run( f"Would copy {font_file.name} to {font_dir}" )
            else:
               self.print_info( f"Copying {font_file.name}" )
               shutil.copy( font_file, font_dir )

   def delete_fonts( self ):
      font_dir = self.resolve_path( "$HOME/Library/Fonts" )
      fonts_source_dir = self.resolve_path( "$PWD/fonts" )
      if not font_dir.is_dir():
         return

      for font_file in fonts_source_dir.rglob( "*.ttf" ):
         target_font = font_dir / font_file.name
         if target_font.exists():
            if self.dry_run:
               self.print_dry_run( f"Would delete {target_font.name}" )
            else:
               self.print_info( f"Deleting {target_font.name}" )
               target_font.unlink()

   def process_apps( self, apps: List[ str ], action: str ):
      self.print_header( f"{action.capitalize()}ing selected dotfiles" )
      if action == "install":
         self.run_command( [ "git", "submodule", "update", "--init",
                             "--recursive" ] )

      for app_name in apps:
         self.print_header( f"{action.capitalize()}ing {app_name} Config" )
         config = self.apps_config[ app_name ]

         if "check" in config:
            check = config[ "check" ]
            path = check.get( "path" )
            if path:
               path = self.resolve_path( path )

            if check[ "type" ] == "cmd_exists" and not self.cmd_exists(
                  check[ "cmd" ] ):
               self.print_warning(
                  f"Command '{check['cmd']}' not found. Skipping {app_name}." )
               continue
            if check[ "type" ] == "dir_exists" and not path.is_dir():
               self.print_warning(
                  f"Directory '{path}' not found. Skipping {app_name}." )
               continue

         steps = config.get( f"{action}_steps", [] )
         for step in steps:
            step_action = step[ "action" ]
            if step_action == "symlink":
               self.create_symlink( step[ "source" ], step[ "target" ] )
            elif step_action == "remove_symlink":
               self.remove_symlink( step[ "target" ] )
            elif step_action == "run_command":
               command = [
                  self.resolve_path( c ) if isinstance( c, str ) and "$" in c else c
                  for c in step[ "command" ]
               ]
               self.run_command( command )
            elif step_action == "ensure_dir":
               self.ensure_dir( step[ "path" ] )
            elif step_action == "install_fonts":
               self.install_fonts()
            elif step_action == "delete_fonts":
               self.delete_fonts()

         self.print_success( f"{app_name} config {action}ed!" )

      self.print_success( f"All selected dotfiles {action} process complete!" )

   def run( self ):
      """Parses command-line arguments and executes the corresponding actions."""
      app_choices = list( self.apps_config.keys() )

      parser = argparse.ArgumentParser(
         description="✨ Dotfiles Installer ✨",
         formatter_class=argparse.RawTextHelpFormatter,
         epilog=__doc__ )
      group = parser.add_mutually_exclusive_group()
      group.add_argument(
         "-i",
         "--install",
         nargs='*',
         choices=app_choices,
         help=
         "Install dotfiles for specific applications.\nIf no apps are specified, all apps will be installed."
      )
      group.add_argument(
         "-d",
         "--delete",
         nargs='*',
         choices=app_choices,
         help=
         "Delete dotfiles for specific applications.\nIf no apps are specified, all apps will be deleted."
      )
      parser.add_argument( "--setup-macos",
                           action="store_true",
                           help="Run macOS setup commands." )
      parser.add_argument( "--dry-run",
                           action="store_true",
                           help="Print commands without executing them." )

      args = parser.parse_args()
      self.dry_run = args.dry_run

      if self.dry_run:
         self.print_header( "DRY RUN MODE ENABLED" )

      if args.setup_macos:
         macos_setup = MacOSSetup( self.macos_setup_config, self.dry_run )
         macos_setup.run()

      install_apps = args.install
      delete_apps = args.delete

      apps_to_install = []
      if isinstance( install_apps, list ):
         apps_to_install = install_apps if install_apps else app_choices

      apps_to_delete = []
      if isinstance( delete_apps, list ):
         apps_to_delete = delete_apps if delete_apps else app_choices

      if install_apps is None and delete_apps is None and not args.setup_macos:
         apps_to_install = app_choices

      if apps_to_install:
         self.process_apps( apps_to_install, "install" )
      elif apps_to_delete:
         self.process_apps( apps_to_delete, "delete" )

if __name__ == "__main__":
   manager = DotfilesManager( Path( "config.yaml" ) )
   manager.run()

