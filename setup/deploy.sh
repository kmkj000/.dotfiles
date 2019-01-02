#!/usr/bin/env bash

cd ~/.dotfiles
if [ $? -ne 0 ]; then
    echo  "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
## makeが使える場合
#if type "make" > /dev/null 2>&1; then
#make
#fi

#シンボリックリンクをはる
cd ~/
find ~/.dotfiles -maxdepth 1 -name ".*" -not -name ".git" -not -name ".dotfiles" | xargs -n 1 ln -sf

if [[ -e ${HOME}/.config ]]; then
  ln -s ${HOME}/.vim ${HOME}/.config/nvim
else
  mkdir -v ${HOME}/.config
  ln -s ${HOME}/.vim ${HOME}/.config/nvim
fi

#DOT_FILES=(.bash_profile .vimrc .vim .local .tmux.conf)
#for file in ${DOT_FILES[@]}
#do
#     ln -sf $DOTPATH/$file $HOME/$file
#done

. ~/.bash_profile
echo "complete deploy!"
