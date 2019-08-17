set nocompatible
set shell=bash\ -i
autocmd BufRead,BufNewFile *.md  setfiletype markdown
filetype off                   " required!

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state($HOME . '/.config/nvim/dein')

  " XDG base direcory compartible
  let g:dein#cache_directory = $HOME . '/.cache/dein'

  " dein begin
  call dein#begin($HOME . '/.config/nvim/dein')

 " プラグインリストを収めた TOML ファイル
 " 予め TOML ファイル（後述）を用意しておく
 let s:toml_dir  = $HOME . '/.config/nvim/dein' 
 let s:toml      = s:toml_dir . '/dein.toml'
 let s:lazy_toml = s:toml_dir . '/dein_lazy.toml'

 " TOML を読み込み、キャッシュしておく
 call dein#load_toml(s:toml,      {'lazy': 0})
 call dein#load_toml(s:lazy_toml, {'lazy': 1})


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
"End dein Scripts-------------------------
let g:deoplete#enable_at_startup = 1

" ###molokai表示設定###
let g:molokai_original = 1
colorscheme molokai
set t_Co=256
"### lightlineの設定
set laststatus=2

filetype plugin indent on
syntax enable

" kannokanno/previm
 autocmd BufRead,BufNewFile *.md set filetype=markdown
 let g:previm_open_cmd = 'open -a Google\ Chrome'
 " ctrl pでプレビュー
 nnoremap <silent> <C-p> :PrevimOpen<CR>

set nocompatible               " be iMproved
filetype off                   " required!
set fenc=utf-8			"文字コード
set nobackup			"バックアップファイル作成しない
set noswapfile			"スワップファイル作成しない
set autoread			"ファイル編集自動読み込み
set noautoindent
"set autoindent " 改行時に前の行のインデントを継続する
set hidden
set showcmd
set cursorline
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest
set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
set list listchars=tab:\▸\-

"インデント
set tabstop=4
set shiftwidth=4
set noexpandtab
"php dictionary読み込み
autocmd FileType php,ctp :set dictionary=~/dotfiles/.vim/dict/php.dict
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:fzf_statusline()
"  Override statusline as you like
	highlight fzf1 ctermfg=161 ctermbg=251
	highlight fzf2 ctermfg=23 ctermbg=251
	highlight fzf3 ctermfg=237 ctermbg=251
	setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
"行数カウント
set number
:command! Nu set relativenumber
:command! NU set relativenumber!
"コード色つけ"
:syntax on

" 矢印キーを無効にする
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
" NERDTree
autocmd vimenter * NERDTree

nnoremap <S-Tab> gt
nnoremap <Tab><Tab> gT
for i in range(1, 9)
    execute 'nnoremap <Tab>' . i . ' ' . i . 'gt'
endfor

" 隠しファイルを表示する
let NERDTreeShowHidden = 1

nnoremap <silent><C-e> :NERDTreeFocusToggle<CR>

" デフォルトでツリーを表示させる
let g:nerdtree_tabs_open_on_console_startup=1

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 画面を分割して定義元へのジャンプ
function! DefinitionJumpWithPhpactor()
    split
    call phpactor#GotoDefinition()
endfunction


" useの補完
nmap <silent><Leader>u      :<C-u>call phpactor#UseAdd()<CR>
" コンテキストメニューの起動(カーソル下のクラスやメンバに対して実行可能な選択肢を表示してくれます)
nmap <silent><Leader>mm     :<C-u>call phpactor#ContextMenu()<CR>
" ナビゲーションメニューの起動(クラスの参照元を列挙したり、他ファイルへのジャンプなど)
nmap <silent><Leader>nn     :<C-u>call phpactor#Navigate()<CR>
" カーソル下のクラスやメンバの定義元にジャンプ
nmap <silent><Leader>o      :<C-u>call phpactor#GotoDefinition()<CR>
" 編集中のクラスに対し各種の変更を加える(コンストラクタ補完、インタフェース実装など)
nmap <silent><Leader>tt     :<C-u>call phpactor#Transform()<CR>
" 新しいクラスを生成する(編集中のファイルに)
nmap <silent><Leader>cc     :<C-u>call phpactor#ClassNew()<CR>
" 選択した範囲を変数に抽出する
nmap <silent><Leader>ee     :<C-u>call phpactor#ExtractExpression(v:false)<CR>
" 選択した範囲を変数に抽出する
vmap <silent><Leader>ee     :<C-u>call phpactor#ExtractExpression(v:true)<CR>
" 選択した範囲を新たなメソッドとして抽出する
vmap <silent><Leader>em     :<C-u>call phpactor#ExtractMethod()<CR>
" split → jump
nmap <silent><C-w><Leader>o :<C-u>call DefinitionJumpWithPhpactor()<CR>
" カーソル下のクラスや変数の情報を表示する
" 他のエディタで、マウスカーソルをおいたときに表示されるポップアップなどに相当
vmap <silent><Leader>hh     :<C-u>call phpactor#Hover()<CR>

autocmd FileType php setlocal omnifunc=phpactor#Complete
