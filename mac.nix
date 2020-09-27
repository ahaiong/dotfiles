# This defines a function taking `pkgs` as parameter, and uses
# `nixpkgs` by default if no argument is passed to it.
{ pkgs ? import <nixpkgs> { config = { allowUnsupportedSystem = true; }; } }:
# This avoids typing `pkgs.` before each package name.
with pkgs;

let
  inherit (lib) optional optionals;
in

# Defines a shell.
mkShell {
  buildInputs = [ 
                  figlet
                  git
                  gnupg
                  grc
                  groovy
                  lolcat
                  openssl
                  telnet
                  tree
                ]
  ++ optional stdenv.isLinux libnotify # For ExUnit Notifier on Linux.
  ++ optional stdenv.isLinux inotify-tools # For file_system on Linux.
  ++ optional stdenv.isDarwin terminal-notifier # For ExUnit Notifier on macOS.
  ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    # For file_system on macOS.
    CoreFoundation
    CoreServices
  ]);
  shellHook = ''
    source bashrc
    figlet "Nix nix!" | lolcat --freq 0.5
    export PS1='\[\033[01;32m\][nix-shell]@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) and $(parse_proxy) \$ '
  '';
}
