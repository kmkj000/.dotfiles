"Display
colorscheme molokai 
set background=dark
set t_Co=256
syntax on   "シンタックスカラーリングを設定する
set number "行番号を表示する
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

" スペース2個
set tabstop=2
set shiftwidth=2
set softtabstop=2

" tabはスペース入力
set expandtab
"自動インデント
set autoindent
set smartindent

if filereadable(expand('~/.vim/fileindent.vimrc'))
  source ~/.vim/fileindent.vimrc
endif

"encoding-------------
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

"dein.vim設定--------------------------------------------
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/dein/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on
syntax enable

"lightline----------------------------------------
if filereadable(expand('~/.vim/lightline.vimrc'))
  source ~/.vim/lightline.vimrc
endif
