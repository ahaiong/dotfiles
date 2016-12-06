# .bashrc

# User specific aliases and functions

#if [ -f ~/.ssh/id_rsa ]; then
#    ssh-add ~/.ssh/id_rsa > /dev/null
#fi    

#PATH=/usr/local/Cellar/ruby/2.0.0-p247/lib/ruby/gems/2.0.0:/usr/local/opt/ruby/bin:/opt/local/sbin:$PATH
#export PATH

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls -G'
#alias sed="gsed"

#export PROMPT_COMMAND='echo -ne "\033]0; ${PWD/#$HOME/~}\007"'
#export PROMPT_COMMAND='echo -ne "\033]0; `basename ${PWD/#$HOME/~}`\007"'
export PROMPT_COMMAND='echo -ne "\033]0; $(basename $(dirname "$PWD"))/$(basename "$PWD")\007" '

git config --global http.proxy $http_proxy
git config --global https.proxy $https_proxy
git config --global url.ssh://git@github.com/.insteadOf https://github.com/
git config --global url.ssh://git@bitbucket.org/.insteadOf https://bitbucket.org/

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
