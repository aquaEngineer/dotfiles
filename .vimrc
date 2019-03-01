set nocompatible
set shell=bash\ -i
autocmd BufRead,BufNewFile *.md  setfiletype markdown
filetype off                   " required!
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" 導入したいプラグインを以下に列挙
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'trusktr/seti.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'suan/vim-instant-markdown'
Plugin 'kannokanno/previm'

" call vundle#end()
 filetype plugin indent on

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
set hidden
set showcmd
set cursorline
set virtualedit=onemore
set smartindent
set showmatch
set laststatus=2
set wildmode=list:longest
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
set tabstop=2

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
nnoremap <silent><C-e> :NERDTreeToggle<CR>
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
