# valiable --------------------------
export TERM=screen-256color-bce
export PS1="\[\e[1;32m\][\u@\H]\[\e[00m\]\[\e[1;34m\][bash:\V]\[\e[00m\]\[\e[1;33m\][\d]\[\e[00m\]\[\e[1;33m\][\t]\[\e[00m\]\[\e[1;31m\][\w]\[\e[00m\]\n\$ "

#OS$B$K$h$C$F(Bls$B$N?'IU$1%*%W%7%g%s$rJQ$($k(B
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
