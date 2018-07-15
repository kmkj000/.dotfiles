# valiable -------------------------
export PATH="${PATH}:~/.dotfiles/bin"
export PS1="\[\e[1;32m\][\u@\H]\[\e[00m\]\[\e[1;34m\][bash:\V]\[\e[00m\]\[\e[1;33m\][\d]\[\e[00m\]\[\e[1;33m\][\t]\[\e[00m\]\[\e[1;31m\][\w]\[\e[00m\]\n\$ "
if [ -f ~/.bash_powerline ]; then
  source ~/.bash_powerline
fi

# alias ----------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#.bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
