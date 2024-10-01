# valiable -------------------------
export DOTFILES_PATH="${HOME}/.dotfiles"
export PATH="${DOTFILES_PATH}/bin:${PATH}"

# fallback PS1
export PS1="\[\e[1;32m\][\u@\H]\[\e[00m\]\[\e[1;34m\][bash:\V]\[\e[00m\]\[\e[1;33m\][\d]\[\e[00m\]\[\e[1;33m\][\t]\[\e[00m\]\[\e[1;31m\][\w]\[\e[00m\]\n\$ "

# Rich PS1
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
if type go > /dev/null 2>&1; then
  export GOPATH=$(go env GOPATH)
  export PATH=${GOPATH}/bin:${PATH}
fi

# kubectl bash-completion ----------
if type -a kubectl > /dev/null 2>&1; then
  case "$(uname -a | awk '{print $1}')" in
    "Darwin" )
      if [ -d $(brew --prefix)/etc/bash_completion.d ] && [ ! -f $(brew --prefix)/etc/bash_completion.d/kubectl ]; then
        kubectl completion bash > $(brew --prefix)/etc/bash_completion.d/kubectl
      fi
      ;;
    "Linux" )
      source <(kubectl completion bash)
      ;;
  esac
fi

# krew (kubernetes plugin manager) ---------
# krew install
if type -a kubectl git > /dev/null 2>&1 && [ ! -d ${HOME}/.krew ]; then
  (
    set -x; cd "$(mktemp -d)" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.4/krew.{tar.gz,yaml}" &&
    tar zxvf krew.tar.gz &&
    KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" &&
    "$KREW" install --manifest=krew.yaml --archive=krew.tar.gz &&
    "$KREW" update
  )
fi
# krew path
if [ -d ${HOME}/.krew ]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# bash-completion -------------
if type -a brew > /dev/null 2>&1 && [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# alias ----------------------------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#.bashrc
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
