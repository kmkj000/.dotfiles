"Display
colorscheme molokai 
set background=dark
set t_Co=256
syntax on   "シンタックスカラーリングを設定する
set number    "行番号を表示する
set cursorline
set title    "編集中のファイル名を表示する
set showcmd    "入力中のコマンドを表示する
set ruler    "座標を表示する
set showmatch   "閉じ括弧の入力時に対応する括弧を表示する
set matchtime=3 "showmatchの表示時間
set laststatus=2    "ステータスラインを常に表示する

set wildmenu wildmode=list:full "補完機能を有効にする

" [Backspace] で既存の文字を削除できるように設定
"  start - 既存の文字を削除できるように設定
"  eol - 行頭で[Backspace]を使用した場合上の行と連結
"  indent - オートインデントモードでインデントを削除できるように設定
set backspace=start,eol,indent

set noswapfile
filetype on
filetype plugin on
filetype indent on

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set t_ut=
