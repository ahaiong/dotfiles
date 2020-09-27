# bashrc

# Tailor the prompt
#export PROMPT_COMMAND='echo -ne "\033]0; $(basename $(dirname "$PWD"))/$(basename "$PWD")\007" '
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) and $(parse_proxy) \$ '
export TERM=xterm-color

# Let's be colourful
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep="grep --color=auto"

if [[ "$system" == "x86_64-darwin" ]]; then
  alias ls='ls --color=auto'
else 
  alias ls='ls -G'
fi

# Not installed by default, but make them colourful
alias tree="tree -C"
#source grc.bashrc

# Set specific colours
export CLICOLORS=1
export LSCOLORS=Exfxcxdxbxegedabagacad

# Lets make less sexy
export LESS='-R'
#export LESSOPEN='|~/.lessfilter %s'

# Lets have an infinite history
HISTSIZE="" 
# What branch is in use
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Is the proxy set?
function parse_proxy {
  if printenv | grep -iqE '^http_proxy|^https_proxy'; then
    echo "proxy on"
  else
    echo "proxy off"
  fi
}

#local sbin scripts, not automatically mapped in macOS
export PATH=$PATH:/usr/local/sbin

#https://github.com/pyenv/pyenv#installation
#export PYENV_ROOT="$HOME/.pyenv"
#export PATH="$PYENV_ROOT/bin:$PATH"
#eval "$(pyenv init -)"
