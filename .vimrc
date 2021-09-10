source ~/dotfiles/.vim_indent_python
" Set compatibility to Vim only - because compatibility with basic Vi turns
" off most of the IMproved stuff
set nocompatible

" Helps force plug-ins to load correctly when it is turned back on below.

set nocp

set noswapfile

set virtualedit=block

" Buffers become hidden when abandoned
set hidden

"use system clipboard
set clipboard=unnamed

" Never get angry again:
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Q q<bang>
command! -bang W w<bang>


" More beautiful vertical spit line
highlight VertSplit cterm=NONE
set fillchars+=vert:\▏

" Longer update times leads to noticable delays
set updatetime=300

:set number relativenumber

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



" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

let g:ale_disable_lsp = 1

set t_Co=256
syntax on
set background=dark


" New splits
nmap <leader>s :split<CR>
nmap <leader>v :vsplit<CR>

" set the runtime path to include vim-plug and initialize
call plug#begin('~/.vim/plugged')


"Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
"Plug 'python-rope/ropevim'
Plug 'psliwka/vim-smoothie'
Plug 'makerforceio/CoVim'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dispatch'

Plug 'apalmer1377/factorus'

" Amazing when writing markdown in vim, just paste image from clipboard
Plug 'ferrine/md-img-paste.vim'
autocmd FileType markdown nmap <buffer><silent> <leader><leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'img'
"let g:mdip_imgname = 'image'

Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1

Plug 'fisadev/vim-isort'
Plug 'voldikss/vim-floaterm'

"Plug 'chaoren/vim-wordmotion'

"Plug 'unblevable/quick-scope'
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
"highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=154 cterm=underline
"highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=80 cterm=underline
"let g:qs_max_chars=150

if executable('rg')
    let g:rg_derive_root='true'
endif

" Visually select more than 1 word and hit * to search for longer texts
Plug 'nelstrom/vim-visual-star-search'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'

" Automatically clear search highlighting after move of cursor.
Plug 'haya14busa/is.vim'

let g:UltiSnipsExpandTrigger = "<nop>"

Plug 'gruvbox-community/gruvbox'
" Plug 'cocopon/iceberg.vim'
" Plug 'morhetz/gruvbox'

let g:fzf_layout = { 'window': {'width': 0.85, 'height':0.85} }
let $FZF_DEFAULT_OPTS='--reverse'

" Allow passing optional flags into rg
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . <q-args>, 1, <bang>0)

Plug 'turbio/bracey.vim'

Plug 'mhinz/vim-grepper'

let g:grepper={}
let g:grepper.tool=["rg"]

" Project wide find and replace (can do regexes if goes to the replaced stuff)
nnoremap <Leader>R
	\ :let @s='\<'.expand('<cword>').'\>'<CR>
	\ :Grepper -cword -noprimpt<CR>
	\ :cfdo %s/<C-r>s// \| update
	\<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

nnoremap <C-g> :Rg<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>h :History<CR>

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
  \ }

Plug 'scrooloose/nerdcommenter'
vmap <leader>c <plug>NERDCommenterToggle
nmap <leader>c <plug>NERDCommenterToggle
let g:NERDDefaultAlign = 'start'

Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
Plug 'sstallion/vim-cursorline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
"Coc is confused? run ":CocRes'

"set statusline^=%{coc#status()}

" Add airline to Tmux
" For now, we alerady snapshotted the vim tmuxline.vim config for .tmux.conf...
" Btw. you can snapshot it by :TmuxlineSnaphot [file] (for me file=.tmuxline)
"Plug 'edkolev/tmuxline.vim'

Plug 'Konfekt/FastFold'
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_fold_blank = 1

filetype plugin on
" Plug 'kalekundert/vim-coiled-snake'

let g:coiled_snake_explicit_sign_width = 1

"set foldmethod=syntax


" Checking syntax on every change
"
" use coc-linter instead
" Plug 'vim-syntastic/syntastic'

Plug 'relastle/vim-nayvy'
Plug 'tpope/vim-surround'

" Airline plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 0

"Plug 'itchyny/lightline.vim'
"
"
"let g:lightline = {
"      \ 'colorscheme': 'seoul256',
"      \ 'active': {
"      \   'left': [ [ 'mode', 'paste' ],
"      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"      \ },
"      \ 'component_function': {
"      \   'gitbranch': 'FugitiveHead'
"      \ },
"      \ }

" set alternate color for modified active/inactive tabs

Plug 'vimwiki/vimwiki'

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'},
		      \	 {'path': '~/my_site/',
                      \ 'syntax': 'markdown', 'ext': '.md'},
		      \	 {'path': '~/tools/private-wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'},
		      \	 {'path': '~/tools/extendwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_ext2syntax = {'.md': 'markdown'}



Plug 'tpope/vim-projectionist'
" Best thing ever I am mindblown

let g:markdown_folding = 1


"!pip install --user smdv
"Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
filetype plugin indent on
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
let g:instant_markdown_autostart = 0
map <leader>md :InstantMarkdownPreview<CR>

"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'

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

"let g:lsp_preview_autoclose = 1
"let g:lsp_signature_help_enabled = 0
"let g:lsp_signs_error = {'text': '✗'}
"let g:lsp_signs_enabled = 1         " enable signs
"let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
"let g:asyncomplete_auto_popup = 1

"function! s:on_lsp_buffer_enabled() abort
"setlocal omnifunc=lsp#complete
"setlocal signcolumn=yes
"if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"endfunction


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
"let g:asyncomplete_smart_copletion = 1
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

" Show da context
" Plug 'wellle/context.vim'

let g:context_highlight_tag = '<hide>'


"Plug 'svermeulen/vim-easyclip'
"let g:EasyClipPreserveCursorPositionAfterYank = 1

" Indent python
Plug 'vim-scripts/indentpython.vim'

" Send ma python code straight into REPL
Plug 'lotabout/slimux'

let g:slimux_select_from_current_window = 1
map <Leader>;; :SlimuxREPLSendLine<CR>
nnoremap <Leader>;k /if __name__ == "__main__":<CR> <bar> kVgg :SlimuxREPLSendSelection<CR>
nnoremap <Leader>;j /if __name__ == "__main__":<CR> <bar> jVG :SlimuxREPLSendSelection<CR>
vmap <Leader>;; <Esc>mzgv:SlimuxREPLSendSelection<CR>`z
map <Leader>;b :SlimuxREPLSendBuffer<CR>
" Explore current pandas df word under cursor
map <Leader>;v :call SlimuxSendCommand('from visidata import view_pandas as vd; vd(' . expand('<cword>') . ')')<CR>
" Print current word under cursor

vnoremap y <Esc>mzgvy<CR>`z

" Easy-motion
" Plug 'easymotion/vim-easymotion'

"Plug 'ptzz/lf.vim'
"let g:lf_map_keys = 0
"nmap <C-p> :Lf<CR>


Plug 'tpope/vim-fugitive'
    " :G to bring the window, '-' to stage/unstage, '=' to view diff, 'cc' to commit
    " out of window: press '=' - brings up inline diff, select hunk via visual and press '-'
    " merge conflicts: ':G', pres dv on the file that I want to resolve, to close C-w + C-O (or S-o)
    " gitignore: ':G' go to a file and type any number 7gI, or 4gI and it will " autoadd it to gitignore
    " In vim-fugitive, if you don’t like your random changes to a file, just push “X” while over it.


nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>




Plug 'sodapopcan/vim-twiggy'

map <Leader>b :G \| Twiggy<CR>
nnoremap <expr> <Leader>nb ":Twiggy " . input("Branch name: ") "\<ESC>"
" map <Leader>bn :Twiggy <C-\><C-o>:call <SID>Twigg_new_branch()<CR><C-r>=branch_name<CR>
"
Plug 'nvie/vim-flake8'

nnoremap <leader><leader>f :call Flake8()<CR>

let g:cocPlugInstall = 'yarn install --frozen-lockfile'
Plug 'neoclide/coc-json', {'do': cocPlugInstall }
Plug 'neoclide/coc-python', {'do': cocPlugInstall }
Plug 'neoclide/coc-snippets', {'do': cocPlugInstall }


" jedi
let g:jedi#completions_enabled = 0
let g:jedi#goto_stubs_command = ''

" Temporary fix on every go-to definition, save the file to omit that typical jedi error
nmap <buffer> gd :w<CR><Plug>(coc-definition)

Plug 'mbbill/undotree' ":UndotreeToggle || press ? while in undotree window
nmap <leader>u :UndotreeToggle<CR>


Plug 'honza/vim-snippets'

let g:ultisnips_python_style="google"
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? coc#_select_confirm() :
      "\ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'



Plug 'christoomey/vim-tmux-navigator'

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
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)

" NERDTreesyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
"nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

Plug 'ludovicchabant/vim-gutentags'
" Plug 'wookayin/vim-autoimport'
"Plug 'scrooloose/nerdtree'

"" NERDTreeTabs
"Plug 'jistr/vim-nerdtree-tabs'

"" NERDTree ignore *.pyc *.swp
"let NERDTreeIgnore=['\.pyc$', '\.swp$', '\~$'] "ignore files in NERDTree


"map <Leader>n <plug>NERDTreeTabsToggle<CR>

" All of your Plugs must be added before the following line
call plug#end()            " required

nnoremap <leader>y :call PlotlySaveAndYank()<CR>
function! PlotlySaveAndYank()
exec "normal ?def\<CR>wyt(\<C-o>ofig.write_image('images/"
  exec "normal pA.png')"
  exec "normal =="
  exec "normal o![alt text]('images/"
  exec "normal pA.png')"
  exec "normal dd"
endfunction

function! ReportFigure()
  let curr_dir= expand("%:p:h")
  " I forgot to actually increase the number here
  let output = system("ls ' . curr_dir . '/images | awk -F '[_.]' '{print $(NF-1)}' | sort | tail -n 1")
  exec "insert fig.write_image("images/fig_" . output . ".png")<Esc>A:i![alt text](images/fig_" . output . ".png)<Esc>C-o <bar> :InstantMarkdownPreview<CR>
endfunction

nnoremap <leader><leader>fp :call SlimuxForPass()<CR> pass
function! SlimuxForPass() abort
  exec "normal A pass"
  exec "normal :SlimuxREPLSendLine\<CR>"
  exec "normal u"
endfunction

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '' . repeat(" ",fillcharcount) . '(' . foldedlinecount . ')' . ' '
endfunction " }}}
set foldtext=MyFoldText()

command! Lfko call LfFloat()

nnoremap <C-p> :Lfko<CR>

function! LfFloat() abort

    let curr_dir= expand("%:p:h")
    let id = Flt_term_win("lf -selection-path /tmp/lf_result " . curr_dir, 0.85,0.85, '')
    execute 'autocmd BufWipeout * ++once call Open_lf_callback("/tmp/lf_result")'
    return winbufnr(id)
endfunction

function! Open_lf_callback(selection_path) abort
    let s:choice_file_path = '/tmp/lf_result'
    if filereadable(a:selection_path)
      for f in readfile(a:selection_path)
        exec "edit " . f
      endfor
    endif
    call delete(a:selection_path)
    redraw!
    " reset the filetype to fix the issue that happens
    " when opening lf on VimEnter (with `vim .`)
    filetype detect
endfunction


function! Flt_term_win(cmd, width, height, border_highlight) abort
    let width = float2nr(&columns * a:width)
    let height = float2nr(&lines * a:height)
    let bufnr = term_start(a:cmd, {'hidden': 1, 'term_finish': 'close'})

    let winid = popup_create(bufnr, {
	    \ 'minwidth': width,
	    \ 'maxwidth': width,
	    \ 'minheight': height,
	    \ 'maxheight': height,
	    \ 'border': [],
	    \ 'borderchars': ['─', '│', '─', '│', '┌', '┐', '┘', '└'],
	    \ 'borderhighlight': [a:border_highlight],
	    \ 'padding': [0,1,0,1],
	    \ 'highlight': a:border_highlight
	    \ })

    " Optionally set the 'Normal' color for the terminal buffer
    call setwinvar(winid, '&wincolor', 'Cool')
    return winid

endfunction

function! GFilesFallback()
  let curr_dir= expand("%:p:h")
  let output = system('git -C ' . curr_dir . ' rev-parse --show-toplevel')
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files \%:p:h\<CR>"
  endif
  return 0
endfunction

nnoremap <C-f> :call GFilesFallback()<CR>


" Do not add regular n and N for search into jumplist
nnoremap <silent> n :<C-u>execute "keepjumps norm! " . v:count1 . "n"<CR>
nnoremap <silent> N :<C-u>execute "keepjumps norm! " . v:count1 . "N"<CR>

" Their counterparts here
nnoremap <leader>n n
nnoremap <leader>N N

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


:augroup *.py numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained * set relativenumber
:  autocmd BufLeave,FocusLost * set norelativenumber
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

" Automatically wrap text that extends beyond the screen length. (OR NOT)
set wrap

" Vim's auto indentation feature does not work properly with text copied from
" outisde of Vim. Press the <F2> key to toggle paste mode on/off.
" Or just select your stuff and use " '='
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>


" Display 7 lines above/below the cursor when scrolling with a mouse.
set scrolloff=7
" Fixes common backspace problems
set backspace=indent,eol,start

" Remap confirmation for searches
cnoremap jk <CR>
cnoremap kj <CR>

" This remap is really bad when controlling visual selection
" vno jk <Esc>
" vno kj <Esc>

" the greatest one
vnoremap <leader>p "_dP

" Do the harlem shake!
set mouse=a

" NERDTree keybindings
let NERDTreeQuitOnOpen=1 " Autoclose NERDTREE on file opening
let NERDTreeMapActivateNode='l' " Toggle child nodes with l
"let NERDTreeMapActivateNode='h' " Toggle child nodes with h
"let NERDTreeMapCloseChildren='h' " Close  child nodes with h

" Speed up scrolling in Vim
set ttyfast
set lazyredraw

" Nicer visual selection
hi Visual term=bold cterm=bold guibg=green

" Status bar
set laststatus=1

" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

highlight LineNr ctermfg=grey

" Display options
set showmode
set showcmd


" Highlight matching pairs of brackets.
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
vnoremap <leader>gv :<c-u>exe '!git log -L' line("'<").','.line("'>").':'.expand('%')<CR>


nnoremap <leader>o :normal yiwologger.debug(f"<Esc>pa: {<Esc>pa}")<Esc>
vnoremap <leader>o yologger.debug(f"<Esc>pa: {<Esc>pa}")<Esc>


" Show line numbers
set number

" Full stack dev indentation
au BufNewFile,BufRead *.js,*.html,*.css, *.yaml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab

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

" Override w motion
function! MyWMotion()
    " Save the initial position
    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! w
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal k$
    endif
endfunction

" Override b motion
function! MyBMotion()
    " Save the initial position
    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! b
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal j^
    endif
endfunction

" Override w motion
function! MyCapWMotion()
    " Save the initial position
    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! W
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal k$
    endif
endfunction

" Override b motion
function! MyCapBMotion()
    " Save the initial position
    let initialLine=line('.')

    " Execute the builtin word motion and get the new position
    normal! B
    let newLine=line('.')

    " If the line as changed go back to the previous line
    if initialLine != newLine
        normal j^
    endif
endfunction
nnoremap <silent> w :call MyWMotion()<CR>
nnoremap <silent> b :call MyBMotion()<CR>
nnoremap <silent> W :call MyCapWMotion()<CR>
nnoremap <silent> B :call MyCapBMotion()<CR>

"function! ScrollQuarter(move)
    "let height=winheight(0)

    "if a:move == 'up'
        "let key="k"
    "else
        "let key="j"
    "endif

    ""execute 'normal! ' . height/7 . key
    "execute 'normal! ' . 4 . key
"endfunction

"nnoremap <silent> <C-u> :call ScrollQuarter('up')<CR>
"nnoremap <silent> <C-d> :call ScrollQuarter('down')<CR>


" One of the least invasive pep8 fun
highlight ColorColumn ctermbg=59 guibg=grey
call matchadd('ColorColumn', '\%81v', 100)

" Store info from no more than 101 files at a time, 9999 lines of text,
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s101

" Press * to search for the term under the cursor a visual selection and
" then <leader>r to replace all the instances in the curr file.
nnoremap <Leader>r :%s///g<Left><Left>
xnoremap <Leader>r :s///g<Left><Left>

nnoremap <Leader>rc :%s///gc<Left><Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Leader>f @=(foldlevel('.')?'za':"\<Leader>")<CR>
vnoremap <Leader>f zf

" Kube sync the currently edited file to your development pod
nnoremap <leader>ks :Start! ks % <CR>


" I don't like background highlighting at all
highlight Folded ctermbg=black

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif


nnoremap j gj
nnoremap k gk
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
"
"" Vimwiki autosave
augroup vimwikisave
    autocmd!
    autocmd BufWritePost */tools/extendwiki/** execute ':silent ! cd ~/tools/extendwiki && nohup $(if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . && git commit -m "Auto-commit: saved %" && git push; fi > /dev/null 2>&1) &'
augroup end

" Automatically create dirs if missing on :e/newdir/file.py
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

"" Move position of my global marks to last editing position
augroup VIMRC
  autocmd!

  autocmd BufWinLeave *.vimrc normal! mV
  autocmd BufWinLeave *.zshrc normal! mZ
  autocmd BufWinLeave Makefile normal! mM
augroup END


au FileType python let b:coc_root_patterns = ['.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyrightconfig.json', 'env']

let g:nayvy_pyproject_root_markers = [
  \ 'pyproject.toml',
  \ 'setup.py',
  \ 'setup.cfg',
  \ 'requirements.txt',
\ ]

let g:nayvy_linter_for_fix = "flake8"
let g:nayvy_import_path_format = "all_absolute"
let g:nayvy_coc_enabled = 1
let g:nayvy_import_config_path = "~/dotfiles/nayvy_config.py"

let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_linters_explicit = 1
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" let g:ale_linters = {'python': ['flake8']}



let g:ale_lint_dirs = {
\    'flake8': getcwd()
\}

let g:ale_fixers = {
\   'python': ['remove_trailing_lines', 'trim_whitespace', 'isort', 'black'],
\   'javascript': ['eslint'],
\}
"let g:ale_fixers = {
"\   'python': ['remove_trailing_lines', 'trim_whitespace', 'isort', 'black'],
"\   'javascript': ['eslint'],
"\}
"

let g:ale_fix_on_save = 1

" Format by black on save
"augroup black_python
  "autocmd!
   "autocmd BufWritePre *.py :Format
"augroup END
"

" This is for preserving folds, if not working, add incremental number to the
" last argument up to 9, after that clear all files from mkview dir
"augroup remember_folds
"  autocmd!
"  au BufWinLeave ?* mkview!
"  au BufWinEnter ?* silent! loadview
"augroup END
"set viewoptions-=options
"" This appears to be crucial for everything to work (OR NOT AT ALL)
"let g:fastfold_savehook = 0

" Remove trailing whitespace on save
"augroup trailin_remove
  "autocmd!
  "autocmd BufWritePre * %s/\s\+$//e
"augroup END

:command! Json :%!python -m json.tool

set cursorline

let g:pythonStdlibPath = '~/.pyenv/versions/3.7.7/lib/python3.7/site-packages/'


function! RooterFileShow() abort
    :Rooter
    :f
endfunction

command! F call RooterFileShow()

" colorscheme gruvbox8
set noshowmode
set shortmess+=F
colorscheme gruvbox
let g:fzf_colors =
\ { 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal']}
hi Normal guibg=NONE ctermbg=NONE
hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan
source ~/.vim/python_ropevim.vim
