# bash ------------------------
#OSによってlsの引数を変更
case "${OSTYPE}" in
    darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color=auto'
        ;;
esac
#一応確認入れる
alias rm='rm -i'

#..で親ディレクトリへ
alias ..='cd ..'

#上書き対策
alias mv='mv -i'

# tree
if [ ! `type tree > /dev/null 2>&1` ]; then
  alias tree="pwd;find . | sort | sed '1d;s/^\.//;s/\/\([^/]*\)$/|--\1/;s/\/[^/|]*/|  /g'"
fi

# git -------------------------
# remoteで削除されているbranchを削除する
alias gitclean='git branch --format "%(refname:short) %(upstream:track)" | grep "\[gone\]" | awk '\''{print $1}'\'' | xargs -IXXX git branch -D XXX'

# vi --------------------------
if type nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
fi

# tmux ------------------------
# color = 256
alias tmux='tmux -2'

