# This defines a function taking `pkgs` as parameter, and uses
# `nixpkgs` by default if no argument is passed to it.
#{ pkgs ? import <nixpkgs> {} }:
{ pkgs ? import <nixpkgs> { config = { allowUnsupportedSystem = true; allowUnfree = true; }; } }:
#{ pkgs ? import <nixpkgs> { overlays = [ (import ./nix-overlays/terraform_0_13_5.nix) ]; config = { allowUnsupportedSystem = true; }; } }:
# This avoids typing `pkgs.` before each package name.
with pkgs;

let
  inherit (lib) optional optionals;
in

# Defines a shell.
mkShell {
  baseInputs = [];
  buildInputs = [
                  python3
                  python3Packages.pip
                  graphviz
                  bicep
                  packer
                  pkg-config
                  ruby
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
                  openssh
                  openssl
                  nox
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
                  tree
                  unzip
                  wget
                  which
                  #nix-os
                  yarn
                  figlet
                  lolcat
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
    figlet "Nix nix!" | lolcat --freq 0.5
    export PS1='\[\033[01;32m\][nix-shell]@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) and $(parse_proxy) \$ '
    export TERM=xterm-color
    export PATH="$PWD/node_modules/.bin/:$PATH"
    if [[ -d $HOME/opt/tfenv/bin ]]; then export PATH=$HOME/opt/tfenv/bin:$PATH; fi
    # https://github.com/tfutils/tfenv
    if [[ -d /opt/mssql-tools18 ]]; then export PATH=/opt/mssql-tools18/bin:$PATH; fi
    # https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=go%2Clinux&pivots=cs1-bash#download-and-install-sqlcmd

    alias rm='rm -i'
    alias cp='cp -i'
    alias mv='mv -i'
    alias grep="grep --color=auto"
    alias tree="tree -C"

    export LESS='-R'
    export CLICOLORS=1
    export LSCOLORS=Exfxcxdxbxegedabagacad

    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    export PATH="/mnt/c/Program\ Files/Oracle/VirtualBox:$PATH"
    export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/mnt/c/Users/andrewh"

    HISTCONTROL=ignoredups:erasedups
    HISTIGNORE="ll:bg:fg:history"
    HISTFILE=$HOME/.logs/$(tty | awk -F "/" '{print $NF}')_$(date +"%Y%m%d_%H%M")_bash_history
    HISTSIZE=""
    shopt -s histappend

    function parse_git_branch() {
      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
    }

    function parse_proxy {
      if printenv | grep -iqE '^http_proxy|^https_proxy'; then
        echo "proxy on"
      else
        echo "proxy off"
      fi
    }

    function install_sqlcmd {
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
      curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
      apt-get update && apt-get install sqlcmd
    }
  '';
}
