#!/bin/bssh

DOTPATH=~/.dotfiles
GITHUB_URL=https://github.com/kmkj000/.dotfiles.git

# git が使えるなら git
if type "git" > /dev/null 2>&1; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif type"curl" > /dev/null 2>&1 || type "wget" > /dev/null 2>&1; then
    tarball="https://github.com/kmkj000/.dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if type "curl" > /dev/null 2>&1; then
        curl -L "$tarball"

    elif type "wget" > /dev/null 2>&1; then
        wget -O - "$tarball"

    fi | tar xvz 

    # 解凍したら，DOTPATH に置く
    mv -f .dotfiles-master "$DOTPATH"

    echo "Download Complete"

else
    echo "curl or wget required"
    exit 1
fi

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
find ~/.dotfiles -name ".*" -maxdepth 1 -not -name ".git" -not -name ".dotfiles" | xargs -n 1 ln -sf

#DOT_FILES=(.bash_profile .vimrc .vim .local .tmux.conf)
#for file in ${DOT_FILES[@]}
#do
#     ln -sf $DOTPATH/$file $HOME/$file
#done
