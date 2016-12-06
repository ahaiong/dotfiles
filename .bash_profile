# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH


#alias make='gmake'
#alias port='/opt/local/bin/port'

# Tell ls to be colourful
export CLICOLORS=1
#export LSCOLORS=gxfxcxdxbxegedabagacad
export LSCOLORS=Exfxcxdxbxegedabagacad

# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Tailor the prompt
#export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]$(parse_git_branch) \$ '
export TERM=xterm-color

# SSH as root
sr()
{
        ssh -o StrictHostKeyChecking=no -A root@$1 $2
}
#source "`brew --prefix grc`/etc/grc.bashrc"
#source "`brew --prefix`/etc/grc.bashrc"

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
