{ pkgs ? import <nixpkgs> {
    config = {
      allowUnsupportedSystem = true;
      allowUnfree = true;
    };
  }
}:

with pkgs;

mkShell {
  buildInputs = [
    bash
    coreutils
    curl
    azure-cli
    figlet
    findutils
    gawk
    git
    gnugrep
    gnused
    gnutar
    gzip
    lolcat
    rustup
    vim
  ];

  shellHook = ''
    figlet "Nix nix!" | lolcat --freq 0.5
    export PS1='\[\033[01;32m\][nix-shell]@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) and $(parse_proxy) $(append_history)\$ '
    export TERM=xterm-256color
    export PATH="$PWD/node_modules/.bin/:$PATH"

    if [[ -d $HOME/opt/tfenv/bin ]]; then export PATH=$HOME/opt/tfenv/bin:$PATH; fi
    if [[ -d /opt/mssql-tools18 ]]; then export PATH=/opt/mssql-tools18/bin:$PATH; fi
    if [[ -d $HOME/opt/go-sqlcmd ]]; then export PATH=$HOME/opt/go-sqlcmd:$PATH; fi
    if [[ -d $HOME/.nvm ]]; then export PATH=$HOME/.nvm:$PATH; fi
    if [[ -d $HOME/opt/ollama ]]; then export PATH=$HOME/opt/ollama/bin:$PATH; fi
    if [[ -d $HOME/opt/assume_role ]]; then export PATH=$HOME/opt/assume_role:$PATH; fi
    if [[ -d $HOME/opt/mw ]]; then export PATH=$HOME/opt/mw:$PATH; fi

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
    HISTFILE=$HOME/.logs/$(TZ="Australia/Sydney" date +"%Y%m%d_%H%M")_$(tty | awk -F "/" '{print $NF}')_bash_history
    HISTSIZE=""
    shopt -s histappend

    function append_history {
      history -w
    }

    function manage_virtual_env_path() {
      local action=$1

      if [ "$action" == "activate" ]; then
        if [ -z "$VIRTUAL_ENV" ]; then
          echo "VIRTUAL_ENV is not set. Please activate a virtual environment first."
        else
          if [ -z "$ORIGINAL_PYTHONPATH" ]; then
            export ORIGINAL_PYTHONPATH="$PYTHONPATH"
          fi
          export PYTHONPATH="$VIRTUAL_ENV/lib/python$(python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')/site-packages"
          echo "PYTHONPATH set to $PYTHONPATH"
        fi

      elif [ "$action" == "deactivate" ]; then
        if [ -n "$ORIGINAL_PYTHONPATH" ]; then
          export PYTHONPATH="$ORIGINAL_PYTHONPATH"
          unset ORIGINAL_PYTHONPATH
          echo "PYTHONPATH restored to ORIGINAL_PYTHONPATH"
        else
          unset PYTHONPATH
          echo "PYTHONPATH unset, no ORIGINAL_PYTHONPATH to restore"
        fi

      else
        echo "Invalid action: use 'activate' or 'deactivate'"
      fi
    }

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

    function install_nvm {
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    }

    function install_odbc_sqlcmd {
      curl https://packages.microsoft.com/keys/microsoft.asc | sudo tee /etc/apt/trusted.gpg.d/microsoft.asc
      curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list
      apt-get update && apt-get install sqlcmd
    }

    function install_go_sqlcmd() {
      _dir=$HOME/opt/go-sqlcmd
      mkdir -p $_dir
      curl -L https://github.com/microsoft/go-sqlcmd/releases/download/v1.8.0/sqlcmd-linux-amd64.tar.bz2 | tar -xj -C "$_dir"
      find $_dir -name "sqlcmd" -print0 | xargs -0 -I {} mv {} $_dir/go-sqlcmd
    }

    function install_vim_addons() {
      _dir=$HOME/.vim
      mkdir -p $_dir
      git clone https://github.com/hashivim/vim-terraform.git ~/.vim/pack/plugins/start/vim-terraform
      git clone https://github.com/LnL7/vim-nix.git ~/.vim/pack/all/start/vim-nix
    }

    function install_ollama() {
      _dir=$HOME/opt/ollama
      mkdir -p $_dir
      curl -L https://ollama.com/download/ollama-linux-amd64.tgz | tar -xz -C "$_dir"
    }

    function install_assume_role() {
      _dir=$HOME/opt/assume_role
      mkdir -p $_dir
      curl -L https://raw.githubusercontent.com/ahaiong/utility-scripts/refs/heads/master/assume_role -o $_dir/assume_role
      chmod +x $_dir/assume_role

      if [[ ":$PATH:" != *":$_dir:"* ]]; then
        export PATH="$_dir:$PATH"
      fi
    }

    function install_mw() {
      _dir=$HOME/opt/mw
      mkdir -p $_dir
      curl -L https://raw.githubusercontent.com/ahaiong/utility-scripts/refs/heads/master/mw -o $_dir/mw
      chmod +x $_dir/mw

      if [[ ":$PATH:" != *":$_dir:"* ]]; then
        export PATH="$_dir:$PATH"
      fi
    }

    rustup default stable
    rustup component add rust-src
  '';
}
