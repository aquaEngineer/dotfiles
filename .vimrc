set nocompatible
set shell=bash\ -i
autocmd BufRead,BufNewFile *.md  setfiletype markdown
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 導入したいプラグインを以下に列挙
Plugin 'phpactor/phpactor'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'roxma/vim-hug-neovim-rpc'
Plugin 'roxma/nvim-yarp'
Plugin 'kristijanhusak/deoplete-phpactor'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'trusktr/seti.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'kannokanno/previm'
Plugin 'conradirwin/vim-bracketed-paste' "ペースト時のインデント崩れ防止
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'shougo/deoplete.nvim'

let g:deoplete#enable_at_startup = 1
 call vundle#end()
 filetype plugin indent on

 colorscheme molokai
 let g:molokai_original = 1
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

" install vim-pulg                                                                                                                                        
 if has('vim_starting')
   set rtp+=~/.vim/plugged/vim-plug
     if !isdirectory(expand('~/.vim/plugged/vim-plug'))
         echo 'install vim-plug...'
             call system('mkdir -p ~/.vim/plugged/vim-plug')
                 call system('
                 curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
                   end
                   endif
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
set list listchars=tab:\▸\-
set tabstop=4

"インデント
set tabstop=4
set shiftwidth=4
set noexpandtab
"php dictionary読み込み
autocmd FileType php,ctp :set dictionary=~/dotfiles/.vim/dict/php.dict
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
"vim-plug
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'edkolev/promptline.vim'
Plug '/usr/local/opt/fzf'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle'] }
" Vundle/NeoBundle と同じように
" 指定したファイルタイプを開いたときに読み込む
Plug 'tpope/vim-fireplace', { 'for': ['clojure'] }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
call plug#end()

function! s:fzf_statusline()
				 "  Override statusline as you like
					   highlight fzf1 ctermfg=161 ctermbg=251
					     highlight fzf2 ctermfg=23 ctermbg=251
					       highlight fzf3 ctermfg=237 ctermbg=251
					         setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
					         endfunction
set rtp+=~/.vim/bundle/vundle/
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
