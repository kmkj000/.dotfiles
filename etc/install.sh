#...

DOTPATH=~/.dotfiles
GITHUB_URL=git@github.com:kmkj000/.dotfiles.git

# git が使えるなら git
if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif has "curl" || has "wget"; then
    tarball="https://github.com/kmkj000/.dotfiles/archive/master.tar.gz"

    # どっちかでダウンロードして，tar に流す
    if has "curl"; then
        curl -L "$tarball"

    elif has "wget"; then
        wget -O - "$tarball"

    fi | tar xv -

    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"

else
    echo "curl or wget required"
    exit 1
fi

cd ~/.dotfiles
if [ $? -ne 0 ]; then
    echo  "not found: $DOTPATH"
fi

# 移動できたらリンクを実行する
make deploy
