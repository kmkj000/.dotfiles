#!/bin/sh

DOTPATH=~/.dotfiles



#リンクを作成していく
for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv "$DOTPATH"/"$f" "$HOME"/"$f"
done
