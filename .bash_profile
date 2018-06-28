# valiable -------------------------
export PATH="${PATH}:~/.dotfiles/bin"
export PS1="\[\e[1;32m\][\u@\H]\[\e[00m\]\[\e[1;34m\][bash:\V]\[\e[00m\]\[\e[1;33m\][\d]\[\e[00m\]\[\e[1;33m\][\t]\[\e[00m\]\[\e[1;31m\][\w]\[\e[00m\]\n\$ "
if [ -f ~/.bash_powerline ]; then
  source ~/.bash_powerline
fi

#OSによってlsの引数を変更
case "${OSTYPE}" in
    darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac

# alias ----------------------------
#gitlog$B$G%0%i%UIU$-$N(Bgit log$B$r<B9T(B
alias gitlog="git log --graph"


#.bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
