# valiable -------------------------
export PATH="${HOME}/.dotfiles/bin:${PATH}"
export PS1="\[\e[1;32m\][\u@\H]\[\e[00m\]\[\e[1;34m\][bash:\V]\[\e[00m\]\[\e[1;33m\][\d]\[\e[00m\]\[\e[1;33m\][\t]\[\e[00m\]\[\e[1;31m\][\w]\[\e[00m\]\n\$ "
if [ -f ~/.bash_powerline ]; then
  source ~/.bash_powerline
fi
# set a fancy prompt (non-color, unless we know we "want" color)
case "${TERM}" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# **env -----------------------------
export PATH="${HOME}/.anyenv/bin:${PATH}"
eval "$(anyenv init -)"

# need after anyenv init
if [ -n "${GOPATH}" ]; then
  export PATH=${GOPATH}/bin:${PATH}
fi

# alias ----------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#.bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
