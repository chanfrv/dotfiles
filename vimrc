": Vim {{{

set nocompatible
syntax on
filetype off

set encoding=utf-8
set backspace=indent,eol,start
set background=dark
set history=5000
set mouse=a         "mouse
set number          "line numbers
set laststatus=2    "statusline
set autoread
set ruler
set ignorecase "case insensitive search/cmds
set smartcase  "sometimes case sensitive
set foldmethod=marker

set autoindent
set smartindent
set expandtab
set softtabstop=4 shiftwidth=4 tabstop=4

let &t_ut=''

set listchars=tab:▹\ ,trail:·,precedes:←,extends:→
set nolist
nnoremap <leader>c :set nolist!<CR>

" C
autocmd Filetype c    nnoremap <buffer> <F5>  :!make<CR>
autocmd Filetype c    nnoremap <C-Y>          :YcmGenerateConfig<CR>
" C++
autocmd Filetype cpp  nnoremap <buffer> <F5>  :!make<CR>
autocmd Filetype cpp  nnoremap <C-Y>          :YcmGenerateConfig<CR>
" RUST
autocmd Filetype rust nnoremap <buffer> <F5>  :!cargo build<CR>
autocmd Filetype rust nnoremap <buffer> <F6>  :!cargo run<CR>
autocmd Filetype rust nnoremap <buffer> <F7>  :!cargo test<CR>
autocmd Filetype rust nnoremap <buffer> <F8>  :!cargo bench<CR>
autocmd Filetype cfg  nnoremap <buffer> <F5>  :!cargo update<CR>

":}}}

": Vundle - https://aur.archlinux.org/vundle.git {{{

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'rust-lang/rust.vim'             "rust
Plugin 'itchyny/lightline.vim'          "statusline
Plugin 'tpope/vim-fugitive'             "git integration
Plugin 'Yggdroot/indentLine'            "indentation guide
Plugin 'JuliaEditorSupport/julia-vim'   "julia

"Plugin 'sheerun/vim-wombat-scheme'
"Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'

call vundle#end()
filetype plugin indent on

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Indentline
let g:indentLine_char = '▏'

" Colorscheme
"colorscheme wombat
"colorscheme gruvbox
colorscheme onedark

" Lightline
set noshowmode
let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead'
            \ },
        \ }

": }}}
