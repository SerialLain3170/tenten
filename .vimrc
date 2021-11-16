set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

colorscheme molokai

set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
nnoremap j gj
nnoremap k gk


set list listchars=tab:\▸\-
set expandtab
set tabstop=2
set shiftwidth=2
set backspace=2

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

nmap <Esc><Esc> :nohlsearch<CR><Esc>
imap { {}<LEFT>
imap [ []<LEFT>
imap ( ()<LEFT>

call plug#begin('~/.vim/plugged')
Plug 'Shougo/unite.vim'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0rp/ale'
Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/neosnippet.vim'
Plug 'scrooloose/syntastic'
Plug 'davidhalter/jedi-vim'
Plug 'hynek/vim-python-pep8-indent'
call plug#end()

let g:indent_guides_enable_on_vim_startup = 1

let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

if version < 600
  syntax clear
elseif exists('b:current_after_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn match pythonOperator "\(+\|=\|-\|\^\|\*\)"
syn match pythonDelimiter "\(,\|\.\|:\)"
syn keyword pythonSpecialWord self

hi link pythonSpecialWord    Special
hi link pythonDelimiter      Special

let b:current_after_syntax = 'python'

let &cpo = s:cpo_save
unlet s:cpo_save

syntax on
