# This defines a function taking `pkgs` as parameter, and uses
# `nixpkgs` by default if no argument is passed to it.
#{ pkgs ? import <nixpkgs> {} }:
#{ pkgs ? import <nixpkgs> { config = { allowUnsupportedSystem = true; }; } }:
{ pkgs ? import <nixpkgs> { overlays = [ (import ./nix-overlays/terraform_0_13_5.nix) ]; config = { allowUnsupportedSystem = true; }; } }:
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
                  nodejs-14_x
                  nodePackages.lerna
                  #cloud
                  awscli
                  azure-cli
                  aws-iam-authenticator
                  #boto3
                  docker
                  docker-compose
                  keybase
                  kubernetes
                  kubernetes-helm
                  git
                  gnupg
                  grc
                  groovy
                  go
                  #irssi
                  openssh
                  openssl
                  #ansible
                  python38
                  #python38Packages.boto
                  #python27
                  #python27Packages.boto
                  nox
                  #python27Packages.virtualenv
                  #python27Packages.pip
                  vault
                  vim
                  #obscure packages
                  dive
                  #general 
                  curl
                  dnsutils
                  envsubst
                  file
                  jq
                  yq
                  rsync
                  sudo
                  subversion
                  trivy
                  telnet
                  tree
                  unzip
                  wget
                  which
                  #nix-os
                  yarn
                  figlet
                  lolcat
                  terraform_0_13
                  putty
                  postgresql
                  openvpn
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
    export PATH="$PWD/node_modules/.bin/:$PATH"
  '';
}
