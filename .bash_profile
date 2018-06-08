# valiable --------------------------
export TERM=screen-256color-bce
export PS1="\[\e[1;32m\][\u@\H]\[\e[00m\]\[\e[1;34m\][bash:\V]\[\e[00m\]\[\e[1;33m\][\d]\[\e[00m\]\[\e[1;33m\][\t]\[\e[00m\]\[\e[1;31m\][\w]\[\e[00m\]\n\$ "

#OSによってlsの色付けオプションを変える
case "${OSTYPE}" in
    darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac

# alias ----------------------------
#gitlogでグラフ付きのgit logを実行
alias gitlog="git log --graph"
