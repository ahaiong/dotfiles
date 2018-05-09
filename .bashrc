# .bashrc


# Tailor the prompt
export PROMPT_COMMAND='echo -ne "\033]0; $(basename $(dirname "$PWD"))/$(basename "$PWD")\007" '
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) $PYENV_VERSION and $(parse_proxy) \$ '
export TERM=xterm-color

# Tell ls to be colourful
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -G'

# Set specific colours
export CLICOLORS=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# Lets make less sexy
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'

# Lets have an infinite history
HISTSIZE=""

# What branch is in use
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Is the proxy set?
parse_proxy() {
  if printenv | grep -iqE '^http_proxy|^https_proxy'; then
    echo "proxy on"
  else
    echo "proxy off"
  fi
}

# Setup python pyenv
export WORKON_HOME=~/.python-ve
export PROJECT_HOME=~/python-workspace
eval "$(pyenv init -)"
pyenv virtualenvwrapper_lazy

# Setup nvm
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

# added by Snowflake SnowSQL installer v1.0
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH


