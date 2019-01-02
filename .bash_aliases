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

# git -------------------------
alias gitlog='git log --graph'
alias gs='git status'

# ruby ------------------------
alias be='bundle exec'

# vi --------------------------
if type nvim > /dev/null 2>&1; then
  alias vi='nvim'
  alias vim='nvim'
fi
