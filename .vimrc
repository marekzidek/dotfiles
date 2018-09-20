" Set compatibility to Vim only.
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" Folding plugin
Plugin 'tmhedberg/SimpylFold'

" Indent python
Plugin 'vim-scripts/indentpython.vim'
" NERDTree
Plugin 'scrooloose/nerdtree'

" NERDTreeTabs
Plugin 'jistr/vim-nerdtree-tabs'

" NERDTree ignore *.pyc *.swp
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" See docstrings of the folded code
let g:SimpylFold_docstring_preview=1

map <Leader>n <plug>NERDTreeTabsToggle<CR>
" Auto-complete plugin
Plugin 'Valloric/YouCompleteMe'

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
hi Normal guibg=NONE ctermbg=NONE


:imap jk <Esc>
:imap kj <Esc>

" Remap starting of NerdTree
map <C-n> :NERDTreeToggle<CR>

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Turn on syntax highlighting.
syntax on

" For plug-ins to load correctly.
filetype plugin indent on

" Turn off modelines
set modelines=0

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Automatically wrap text that extends beyond the screen length.
set wrap
" Vim's auto indentation feature does not work properly with text copied from outisde of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>

" Autocomplete plugin customization
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Do the harlem shake!
set mouse=a

" NERDTree keybindings
let NERDTreeQuitOnOpen=1 " Autoclose NERDTREE on file opening
let NERDTreeMapActivateNode='l' " Toggle child nodes with l
"let NERDTreeMapActivateNode='h' " Toggle child nodes with h
"let NERDTreeMapCloseChildren='h' " Close  child nodes with h

" Speed up scrolling in Vim
set ttyfast

" Status bar
set laststatus=2
"
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Display options
set showmode
set showcmd

" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>

" Display different types of white spaces.
set list
set listchars=tab:›\ ,extends:#,nbsp:.

" Show line numbers
set number

" Add the proper PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4 | 
    \ set softtabstop=4 |
    \ set shiftwidth=4 | 
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" Full stack dev indentation
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Split a new window to the right
set splitright
" Split a new window to the bottom
set splitbelow

" Set status line display
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}

" Encoding
set encoding=utf-8

" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 100 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s100

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Automatically save and load folds
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview"
