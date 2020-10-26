"Base Settings -----------------------
"Encoding - - -
"文字コードをUFT-8に設定
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac 

"File process - - -
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

set matchtime=3 "showmatchの表示時間
set pumheight=10 " 補完メニューの高さ
set wildmenu wildmode=list:full "補完機能を有効にする
"ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc> 
set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch " 検索文字列入力時に順次対象文字列にヒットさせる
" Y を、行末までのヤンクにする
nmap Y y$

" [Backspace] の制限をなくす
"  start - 既存の文字を削除できるように設定
"  eol - 行頭で[Backspace]を使用した場合上の行と連結
"  indent - オートインデントモードでインデントを削除できるように設定
set backspace=start,eol,indent

"Sound Setting - - -
"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells "エラーメッセージの表示時にビープを鳴らさない

"Environment - - -
set clipboard=unnamed,unnamedplus " OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set mouse=a " マウスの入力を受け付ける
set shellslash " Windows でもパスの区切り文字を / にする
"set clipboard=unnamed  "yank した文字列をクリップボードにコピー

" pyenvでneovim用に作成したpythonのpath
let g:python_host_prog=$PYENV_ROOT.'/versions/neovim-2/bin/python'
let g:python3_host_prog=$PYENV_ROOT.'/versions/neovim-3/bin/python'


"Display -----------------------------
" Status Line - - -
" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" プレビューウインドウなら[Prevew]と表示
set statusline+=%w
" これ以降は右寄せ表示
set statusline+=%=
" file encoding
set statusline+=[ENC=%{&fileencoding}]
" 現在行数/全行数
set statusline+=[LOW=%l/%L]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

syntax on   "シンタックスカラーリングを設定する
colorscheme dogrun
let g:lightline={
  \ 'colorscheme': 'dogrun',
  \ }
set background=dark
set t_Co=256
set number "行番号を表示する
set title    "編集中のファイル名を表示する
set showcmd    "入力中のコマンドを表示する
set ruler    "座標を表示する
set showcmd "入力したコマンドを表示する
set showmatch   "閉じ括弧の入力時に対応する括弧を表示する
set hls      "検索した文字をハイライトする

" スペース2個
set tabstop=2
set shiftwidth=2
set softtabstop=2
" tabはスペース入力
set expandtab
"自動インデント
set autoindent
set smartindent


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
  if v:version <= 704
    call system('cd ' . s:dein_repo_dir . ' && git checkout -b 1.5 1.5' )
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " deoplete導入
  if ((has('nvim')  || has('timers')) && has('python3')) && system('pip3 show neovim') !=# ''
    call dein#add('Shougo/deoplete.nvim')
    if !has('nvim')
      call dein#add('roxma/nvim-yarp')
      call dein#add('roxma/vim-hug-neovim-rpc')
    endif
  elseif has('lua')
    call dein#add('Shougo/neocomplete.vim')
  endif

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/dein/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " deoplate用の設定
  if dein#tap('deoplete.nvim')
    let g:deoplete#enable_at_startup = 1
  elseif dein#tap('neocomplete.vim')
    let g:neocomplete#enable_at_startup = 1
  endif

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif


filetype on
filetype plugin on
filetype indent on
