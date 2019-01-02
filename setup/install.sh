#!/usr/bin/env bash

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

# 取得できたらデプロイ
~/.dotfiles/setup/deploy.sh
