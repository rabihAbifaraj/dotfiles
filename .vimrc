set nocompatible
set ts=4
set et
set ai
let &t_Co=256
set nu
set relativenumber
set hlsearch

" folding stuff
set foldmethod=marker

" needed for syntax highlighting
filetype on
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2

set showcmd

if version >= 700
set spl=en spell
set nospell
endif

set ignorecase
set smartcase

inoremap jj <Esc>
nnoremap JJJJ <Nop>

set incsearch
set hlsearch
set cursorline
set showmatch

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
" status bar plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
Plug 'cdelledonne/vim-cmake'

" colorscheme
Plug 'lifepillar/vim-gruvbox8'

" filesystem navigation plugin
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" git wrapper
Plug 'tpope/vim-fugitive'

" fzf vim wrapper
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" So, adding ron before gruvbox makes the colorscheme very nice. Otherwise, it
" is too bright. This is weird, but works.
colorscheme ron
colorscheme gruvbox8

" keybindings for fzf
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

" Tell FZF to use RG - so we can skip .gitignore files even if not using
" :GitFiles search
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
" If you want gitignored files:
"let $FZF_DEFAULT_COMMAND = 'rg --files --no-ignore-vcs --hidden'

" set ripgrep as :grep 
set grepprg=rg\ --vimgrep\ --smart-case\ --follow
