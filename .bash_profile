export TERM=screen-256color-bce
#OS$B$K$h$C$F(Bls$B$N?'IU$1%*%W%7%g%s$rJQ$($k(B
case "${OSTYPE}" in
    darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac
#gitlog$B$G%0%i%UIU$-$N(Bgit log$B$r<B9T(B
alias gitlog="git log --graph"
