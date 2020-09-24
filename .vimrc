" Set compatibility to Vim only - because compatibility with basic Vi turns
" off most of the IMproved stuff
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.

set nocp
filetype on
filetype plugin indent on


" Never get angry again:
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Q q<bang>
command! -bang W w<bang>

" Longer update times leads to noticable delays
set updatetime=300


""" Customize colors
func! s:my_colors_setup() abort
    " this is an example
    hi Pmenu guibg=#d7e5dc gui=NONE
    hi PmenuSel guibg=#b7c7b7 gui=NONE
    hi PmenuSbar guibg=#bcbcbc
    hi PmenuThumb guibg=#585858
endfunc

augroup colorscheme_coc_setup | au!
    au ColorScheme * call s:my_colors_setup()
augroup END


" Encoding

set encoding=utf-8

" My leader is space
let mapleader = (' ')

" Some files need more memory for syntax highlight
set mmp=5000



" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Amazing when writing markdown in vim, just paste image from clipboard - fkin
" conventient
Plugin 'ferrine/md-img-paste.vim'
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'img'
"let g:mdip_imgname = 'image'

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
"
" Super ctrl + P searching
" Plugin 'kien/ctrlp.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
let g:fzf_layout = { 'window': {'width': 0.8, 'height':0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
nnoremap <C-f> :Files<CR>

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
  \ }
nnoremap <C-e> :Buffers<CR>

Plugin 'scrooloose/nerdcommenter'
vmap <leader>c <plug>NERDCommenterToggle
nmap <leader>c <plug>NERDCommenterToggle

Plugin 'neoclide/coc.nvim', {'branch': 'release'}
set statusline^=%{coc#status()}

" Add airline to Tmux
" For now, we alerady snapshotted the vim tmuxline.vim config for .tmux.conf...
" Plugin 'edkolev/tmuxline.vim'

"Plugin 'tmhedberg/SimpylFold'
Plugin 'kalekundert/vim-coiled-snake'
Plugin 'Konfekt/FastFold'

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Checking syntax on every change
"
" use coc-linter instead
" Plugin 'vim-syntastic/syntastic'

" Vim - Tmux split navigator with same bindings :))
Bundle 'christoomey/vim-tmux-navigator'

" Airline plugin

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_theme='peaksea'
let g:airline_powerline_fonts = 1

" set alternate color for modified active/inactive tabs

Plugin 'vimwiki/vimwiki'

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'},
		      \	 {'path': '~/my_site/',
                      \ 'syntax': 'markdown', 'ext': '.md'},
		      \	 {'path': '~/tools/extendwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown'}

"!pip install --user smdv
Plugin 'suan/vim-instant-markdown', {'rtp': 'after'}
let g:instant_markdown_autostart = 0
map <leader>md :InstantMarkdownPreview<CR>

"Plugin 'prabirshrestha/async.vim'
"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'prabirshrestha/asyncomplete.vim'
"Plugin 'prabirshrestha/asyncomplete-lsp.vim'

" !pip install python-language-server
"if executable('pyls')
"    " pip install python-language-server
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pyls',
"        \ 'cmd': {server_info->['pyls']},
"        \ 'whitelist': ['python'],
"        \ })
"endif







"let g:LanguageClient_loggingFile = '~/tmp/lc.log'
"let g:LanguageClient_loggingLevel = 'DEBUG'
"
"
"
"
"let g:lsp_preview_autoclose = 1
"let g:lsp_signature_help_enabled = 0
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_enabled = 1         " enable signs
"let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"let g:asyncomplete_auto_popup = 1
"
"
"function! s:on_lsp_buffer_enabled() abort
"setlocal omnifunc=lsp#complete
"setlocal signcolumn=yes
"if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"endfunction
"
"
"augroup lsp_install
"    au!
"        " call s:on_lsp_buffer_enabled only for languages that has the
"" server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
"     augroup END


source ~/dotfiles/coc_config.vim

set completeopt-=preview


" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_smart_completion = 1
"let g:asyncomplete_remove_duplicates = 1

" Syntastic custom config
let g:syntastic_check_on_wq = 0


"nnoremap <leader>r :LspReferences<CR>
"nnoremap <leader>d :LspDefinition<CR>

set completeopt-=preview
" This remap is not so much motivated by lsp, but
" by wierd behaviour of <C-space>, which is <Nul> in vimspeak :D
" it somehow inserts last couple of inserted chars and exits to normal mode
inoremap <Nul> <C-n>

" Indent python
Plugin 'vim-scripts/indentpython.vim'

" Easy-motion
Plugin 'easymotion/vim-easymotion'

Plugin 'tpope/vim-fugitive'

Plugin 'mbbill/undotree' ":UndotreeToggle || press ? while in undotree window

Plugin 'honza/vim-snippets'

"use system clipboard
set clipboard=unnamed


" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
" nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" NERDTreesyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

Plugin 'scrooloose/nerdtree'

" NERDTreeTabs
Plugin 'jistr/vim-nerdtree-tabs'

" NERDTree ignore *.pyc *.swp
let NERDTreeIgnore=['\.pyc$', '\.swp$', '\~$'] "ignore files in NERDTree


map <Leader>n <plug>NERDTreeTabsToggle<CR>

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
hi Normal guibg=NONE ctermbg=NONE

" Let my code be pretty
let python_highlight_all=1
syntax on

" Don't use it now as we already have snapshot of this for .tmux.conf
" let g:tmuxline_preset = 'righteous'

set wildmode=longest,list,full
set wildmenu

" Remap esc to my favorite mix
:imap jk <Esc>
:imap kj <Esc>

:set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"
" Turn off modelines
set modelines=0

set undofile
set undodir=~/.vim/undodir
" !mkdir ~/.vim/undodir

let @p='yiwoprint("kjpA")kjyypf"x;xkVj<................Vjd'

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Automatically wrap text that extends beyond the screen length.
set wrap
" Vim's auto indentation feature does not work properly with text copied from outisde of Vim. Press the <F2> key to toggle paste mode on/off.
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>


" Display 5 lines above/below the cursor when scrolling with a mouse.
set scrolloff=5
" Fixes common backspace problems
set backspace=indent,eol,start

" Remap confirmation for searches
cnoremap jk <CR>
cnoremap kj <CR>

" This remap is really bad when controlling visual selection
" vno jk <Esc>
" vno kj <Esc>

" Do the harlem shake!
set mouse=a

" NERDTree keybindings
let NERDTreeQuitOnOpen=1 " Autoclose NERDTREE on file opening
let NERDTreeMapActivateNode='l' " Toggle child nodes with l
"let NERDTreeMapActivateNode='h' " Toggle child nodes with h
"let NERDTreeMapCloseChildren='h' " Close  child nodes with h

" Speed up scrolling in Vim
set ttyfast

" Nicer visual selection
hi Visual term=bold cterm=bold guibg=green

" Status bar
set laststatus=2
"
" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

highlight LineNr ctermfg=grey


" Display options
set showmode
set showcmd


" Highlight matching pairs of brackets. Use the '%' character to jump between them.
set matchpairs+=<:>


" Enable resize of vim when is tmux
if has("mouse_sgr")
    set ttymouse=sgr
else

  if !has('nvim')
    set ttymouse=xterm2
  endif
end

" Display different types of white spaces.
set listchars=tab:›\ ,extends:#,nbsp:.
set listchars=trail:\

" Toggle lineNumbers
nnoremap <leader>l :set relativenumber!<cr>:set number!<cr>


" Show line numbers
set number

" Full stack dev indentation
au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth

" Add the proper PEP 8 indentation
au BufNewFile,BufRead *.py,*.pyx
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix


" Split a new window to the right
set splitright
" Split a new window to the bottom
set splitbelow




" Settings for compatibility with tmux colorscheme vim
set background=dark
set t_Co=256


" Highlight matching search patterns
set hlsearch
" Enable incremental search
set incsearch
" Include matching uppercase words with lowercase search term
set ignorecase
" Include only uppercase words with uppercase search term
set smartcase

" Store info from no more than 101 files at a time, 9999 lines of text, 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s101

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Leader>f @=(foldlevel('.')?'za':"\<Leader>")<CR>
vnoremap <Leader>f zf

" I don't like background highlighting at all
highlight Folded ctermbg=black

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

""augroup vimrc
""    autocmd BufWritePost *
""    \   if expand('%') != '' && &buftype !~ 'nofile'
""    \|      mkview
""    \|  endif
""    autocmd BufRead *
""    \   if expand('%') != '' && &buftype !~ 'nofile'
""    \|      silent loadview
""    \|  endif
""augroup END

"autocmd VimEnter * silent exec "! echo -ne 'ge[1 q'"
"autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

" Reset cursor on startup
"augroup ResetCursorShape
"au!
"autocmd VimEnter * :normal :startinsert :stopinsert
"augroup END

"" This is for preserving folds, if not working, add incremental number to the
" last argument up to 9, after that clear all files from mkview dir
augroup remember_folds
  autocmd!
  au BufWinLeave ?* mkview! 2
  au BufWinEnter ?* silent! loadview 2
augroup END
set viewoptions-=options

" Remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e
