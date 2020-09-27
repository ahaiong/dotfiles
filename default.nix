# This defines a function taking `pkgs` as parameter, and uses
# `nixpkgs` by default if no argument is passed to it.
#{ pkgs ? import <nixpkgs> {} }:
{ pkgs ? import <nixpkgs> { overlays = [ (import ./nix-overlays/terraform_0_13_0.nix) ]; config = { allowUnsupportedSystem = true; }; } }:
# This avoids typing `pkgs.` before each package name.
with pkgs;

let
  inherit (lib) optional optionals;
in

# Defines a shell.
mkShell {
  baseInputs = [];
  buildInputs = [ 
                  pkg-config
                  nodejs
                  #cloud
                  awscli
                  azure-cli
                  aws-iam-authenticator
                  docker
                  docker-compose
                  #helm #can not derive
                  keybase
                  kubernetes
                  git
                  gnupg
                  grc
                  groovy
                  #irssi
                  openssh
                  openssl
                  #terraform_0_13
                  #ansible
                  #python37
                  #python37Packages.boto
                  #python27
                  #python27Packages.boto
                  nox
                  #python27Packages.virtualenv
                  #python27Packages.pip
                  vault
                  vim
                  #obscure packages
                  #general 
                  curl
                  dnsutils
                  envsubst
                  file
                  jq
                  rsync
                  sudo
                  subversion
                  telnet
                  tree
                  unzip
                  wget
                  which
                  #nix-os
                  figlet
                  lolcat
                  terraform_0_13_0
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
    source ~/bashrc
    figlet "Nix nix!" | lolcat --freq 0.5
    export PS1='\[\033[01;32m\][nix-shell]@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) and $(parse_proxy) \$ '
  '';
}
