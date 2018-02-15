export TERM=screen-256color-bce
#OSによってlsの色付けオプションを変える
case "${OSTYPE}" in
    darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac
#gitlogでグラフ付きのgit logを実行
alias gitlog="git log --graph"
