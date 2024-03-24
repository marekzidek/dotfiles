."\n"
source ~/dotfiles/nvim/mappings.vim
"source ~/dotfiles/nvim/trouble.lua

"let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.9/bin/python3'

set nocp
set noswapfile
set guicursor=n-v-c-i:block
set virtualedit=block
set hidden
set clipboard=unnamed
set encoding=utf-8
set t_Co=256
set background=dark
set completeopt-=preview
set mouse=a
set wildmode=longest,list,full
set wildmenu
set cursorline
set modelines=0
set undofile
set undodir=~/.vim/undodir
" !mkdir ~/.vim/undodir
set fillchars+=vert:\▏
set splitright
set splitbelow
set hlsearch
set incsearch
set ignorecase
set smartcase
set laststatus=1
set updatetime=300
set showmode
set showcmd
set matchpairs+=<:>

if has("mouse_sgr")
    set ttymouse=sgr
else


  if !has('nvim')
    set ttymouse=xterm2
  endif
end

" Store info from no more than 101 files at a time, 9999 lines of text,
" 100kb of data. Useful for copying large amounts of data between files.
set viminfo='100,<9999,s101

" Display different types of white spaces.
set listchars=tab:›\ ,extends:#,nbsp:.
set listchars=trail:\

" Speed up scrolling in Vim
set ttyfast
set lazyredraw

" Some files need more memory for syntax highlight
set mmp=5000

noremap j gj  
noremap k gk
" Automatically wrap text that extends beyond the screen length. (OR NOT)
set wrap

" Display 7 lines above/below the cursor when scrolling with a mouse.
set scrolloff=7

" Fixes common backspace problems
set backspace=indent,eol,start

" More beautiful vertical spit line
highlight VertSplit cterm=NONE

syntax on

" Never get angry again:
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>
command! -bang Q q<bang>
command! -bang W w<bang>

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



" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

let g:ale_disable_lsp = 0


" set the runtime path to include vim-plug and initialize
call plug#begin('~/.vim/plugged')

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'folke/trouble.nvim'






Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
let g:pydocstring_doq_path = "~/.pyenv/versions/3.7.7/bin/doq"
let g:pydocstring_formatter = 'google'
nmap <silent> <C-_> <Plug>(pydocstring)

Plug 'ptzz/lf.vim'

Plug 'voldikss/vim-floaterm'
hi Floaterm guibg=black
let g:floaterm_width = 0.85
let g:floaterm_height = 0.85


Plug 'nvim-lua/plenary.nvim'
"Plug 'haorenW1025/floatLf-nvim'
"let g:floatLf_lf_open = '<c-o>'
"let g:floatLf_autoclose = 1
"let g:floatLf_border = 1


Plug 'nvim-lua/popup.nvim'


Plug 'github/copilot.vim'
imap <silent><script><expr> <C-c> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

Plug 'psliwka/vim-smoothie'
Plug 'tpope/vim-rhubarb'

Plug 'tpope/vim-dispatch'

"Plug 'apalmer1377/factorus'

" Amazing when writing markdown in vim, just paste image from clipboard
Plug 'ferrine/md-img-paste.vim'
let g:mdip_imgdir = 'img'
"let g:mdip_imgname = 'image'

Plug 'airblade/vim-rooter'
let g:rooter_manual_only = 1

"Plug 'fisadev/vim-isort'
Plug 'voldikss/vim-floaterm'


"Plug 'chaoren/vim-wordmotion'

"Plug 'unblevable/quick-scope'
" Trigger a highlight in the appropriate direction when pressing these keys:
"let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
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
"Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
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


let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
  \ }

Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign = 'start'

"Plug 'puremourning/vimspector'
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

"Plug 'relastle/vim-nayvy'
Plug 'tpope/vim-surround'

"Plug 'ptzz/lf.vim'
"Plug 'thezeroalpha/vim-lf'

Plug 'voldikss/vim-floaterm'
let g:floaterm_opener = 'edit'

" Airline plugin
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
let g:airline_theme='tomorrow'
let g:airline_powerline_fonts = 0

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


let src_dir = fnamemodify(getcwd(), ':t')
let g:projectionist_heuristics = {
      \ src_dir . "/*": {
      \     src_dir . "/*.py":
      \     {
      \         "alternate": src_dir . "/tests/{dirname}/test_{basename}.py",
      \         "type": "src",
      \         "template": ["def {basename}():"]
      \     },
      \    src_dir . "tests/**/test_*.py":
      \     {
      \         "alternate": [src_dir . "/{basename}.py", src_dir . "/{dirname}/{basename}.py"],
      \         "type": "test",
      \         "template": ["from " . src_dir . ".{dot} import *\n\ndef test_{underscore}():\n    pass"]
      \     }
      \ }}

Plug 'tpope/vim-projectionist'
" Best thing ever I am mindblown
" Projectionist

let g:markdown_folding = 1


"!pip install --user smdv
"Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
filetype plugin indent on
Plug 'instant-markdown/vim-instant-markdown', {'for': 'markdown'}
let g:instant_markdown_autostart = 0

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
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_smart_copletion = 1
"let g:asyncomplete_remove_duplicates = 1

" Syntastic custom config
let g:syntastic_check_on_wq = 0

"nnoremap <leader>r :LspReferences<CR>
"nnoremap <leader>d :LspDefinition<CR>

" This remap is not so much motivated by lsp, but
" by wierd behaviour of <C-space>, which is <Nul> in vimspeak :D
" it somehow inserts last couple of inserted chars and exits to normal mode
inoremap <Nul> <C-n>

" Show da context
" Plug 'wellle/context.vim'

let g:context_highlight_tag = '<hide>'


"Plug 'svermeulen/vim-easyclip'
"let g:EasyClipPreserveCursorPositionAfterYank = 1

let &statuscolumn='%l  '

" Indent python
Plug 'vim-scripts/indentpython.vim'


vnoremap y <Esc>mzgvy<CR>`z


" Send python code straight into REPL
Plug 'lotabout/slimux'
let g:slimux_select_from_current_window = 1
map <Leader>;; :SlimuxREPLSendLine<CR>
map <Leader>;x :norm ^viW ;;<CR>
map <Leader>;w :norm viw ;;<CR>
map <Leader>;d :call SlimuxSendCommand('%debug')<CR>
map <Leader>;l :call SlimuxSendCommand('len(' . expand('<cword>') . ')')<CR>
map <Leader>;c :call SlimuxSendCommand(expand('<cword>') . '.columns')<CR>
map <Leader>;1 :call SlimuxSendCommand(expand('<cword>') . '.iloc[0]')<CR>
map <Leader>;f :norm mzV^[]]]%jO]][[][k 6<CR>`z
map <Leader>;F :norm mz]]zo`zV^[]]]O]][[][ 6<CR>`z
map <Leader>;m :norm mzV^[mk]m%jO]m[m]Mk 6<CR>`z
map <Leader>;M :norm mz]mzo`zV^[mk]mO]m[m]Mh ;;<CR>`z

nmap <Leader>;k /if __name__ == "__main__":<CR> <bar> kVgg :SlimuxREPLSendSelection<CR>
"nmap <Leader>;j /if __name__ == "__main__":<CR> <bar> jVG :SlimuxREPLSendSelection<CR>
"nmap <Leader>;j /if __name__ == "__main__":<CR> <bar> jVG :SlimuxREPLSendSelection<CR>
vmap <Leader>;; <Esc>mzgv :SlimuxREPLSendSelection<CR>`z
"nmap <Leader>7 :call SlimuxSendCommand('')<CR>
vmap <Leader>99 <Esc>mzgv<leader>j :SlimuxREPLSendSelection<CR>`z
vmap <Leader>6 :SlimuxREPLSendSelection<CR>
"nmap <Leader>88 <Esc>mzgv<leader>j :SlimuxREPLSendSelection<CR>`z
map <Leader>;b :SlimuxREPLSendBuffer<CR>
" Explore current pandas df word under cursor
map <Leader>;v :call SlimuxSendCommand('from visidata import view_pandas; from visidata import vd; view_pandas(vd,' . expand('<cword>') . ')')<CR>
" Print current word under cursor


vnoremap y <Esc>mzgvy<CR>`z

map <Leader>z :s/(/(\r    / <bar> s/.*\zs)/\r)/ <bar> exec "norm k" <bar> s/, /\r    /g <CR>
vmap <Leader>z :norm $x<CR>


Plug 'tpope/vim-fugitive'
    " :G to bring the window, '-' to stage/unstage, '=' to view diff, 'cc' to commit
    " out of window: press '=' - brings up inline diff, select hunk via visual and press '-'
    " merge conflicts: ':G', pres dv on the file that I want to resolve, to close C-w + C-O (or S-o)
    " gitignore: ':G' go to a file and type any number 7gI, or 4gI and it will " autoadd it to gitignore

nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

Plug 'sodapopcan/vim-twiggy'

map <Leader>b :G \| Twiggy<CR>
nnoremap <expr> <Leader>nb ":Twiggy " . input("Branch name: ") "\<ESC>"
" map <Leader>bn :Twiggy <C-\><C-o>:call <SID>Twigg_new_branch()<CR><C-r>=branch_name<CR>

Plug 'relastle/vim-nayvy', { 'on': 'NayvyImports' }
Plug 'nvie/vim-flake8'

nnoremap <leader><leader>f :call Flake8()<CR>

let g:cocPlugInstall = 'yarn install --frozen-lockfile'
Plug 'neoclide/coc-json', {'do': cocPlugInstall }
Plug 'neoclide/coc-python', {'do': cocPlugInstall }
"Plug 'neoclide/coc-pyright', {'do': cocPlugInstall }
"

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
"let g:EasyMotion_smartcase = 1

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

nnoremap Y :let @*=@*.getline('.')."\n"<CR>

function! Get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

vnoremap Y :<C-U>let @*=@*.Get_visual_selection()."\n"

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

nnoremap <leader><leader>fp :call SlimuxForPass()<CR>
function! SlimuxForPass() abort
  exec "normal A pass" pass
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
"let python_highlight_all=1

lua << EOF

vim.diagnostic.config({virtual_text = true,
signs = true,
update_in_insert = false,
underline = true,
severity_sort = true,
-- float = true,
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

syntax on

"FZF Command History
function! s:mycommand_sink(cmd)
    let cmd = substitute(a:cmd, '\d..', '', 'g') 
    execute cmd
endfunction

function! s:commands(bang)
  redir => history
  silent history
  redir END
  let list = split(history, '\n')
    call fzf#run({
                \ 'source':  reverse(extend(list[0:0], map(list[2:], 's:format_cmd(v:val)'))),
                \ 'sink':    function('s:mycommand_sink'),
                \ 'options': '--ansi -x --prompt "Commands> " ',
                \ 'window': 'aboveleft 20new'}, a:bang)
endfunction

command! -bang Cmds call s:commands(<bang>0)
" Don't use it now as we already have snapshot of this for .tmux.conf
" let g:tmuxline_preset = 'righteous'


" Remap esc to my favorite mix
:imap jk <Esc>
:imap kj <Esc>


":augroup *.py numbertoggle
":  autocmd!
":  autocmd BufEnter,FocusGained * set relativenumber
":  autocmd BufLeave,FocusLost * set norelativenumber
":augroup END

":augroup *.py statuslinetoggle
":  autocmd!
":  autocmd BufEnter,FocusGained * set laststatus=2
":  autocmd BufLeave,FocusLost * set laststatus=0
":augroup END


" let @p='yiwoprint("kjpA")kjyypf"x;xkVj<................Vjd'

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>


" Vim's auto indentation feature does not work properly with text copied from
" outisde of Vim. Press the <F2> key to toggle paste mode on/off.
" Or just select your stuff and use " '='
nnoremap <F2> :set invpaste paste?<CR>
imap <F2> <C-O>:set invpaste paste?<CR>
set pastetoggle=<F2>



" Remap confirmation for searches
cnoremap jk <CR>
cnoremap kj <CR>

" This remap is really bad when controlling visual selection
" vno jk <Esc>
" vno kj <Esc>

" the greatest one
vnoremap <leader>p "_dP


" NERDTree keybindings
"let NERDTreeQuitOnOpen=1 " Autoclose NERDTREE on file opening
"let NERDTreeMapActivateNode='l' " Toggle child nodes with l
"let NERDTreeMapActivateNode='h' " Toggle child nodes with h
"let NERDTreeMapCloseChildren='h' " Close  child nodes with h


" Nicer visual selection
hi Visual term=bold cterm=bold guibg=green


" Split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

highlight LineNr ctermfg=grey

" Toggle lineNumbers
" nnoremap <leader>l :set relativenumber!<cr>:set number!<cr>
nnoremap <leader>l <cr>:set number!<cr>
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
"nnoremap <silent> w :call MyWMotion()<CR>
"nnoremap <silent> b :call MyBMotion()<CR>
"nnoremap <silent> W :call MyCapWMotion()<CR>
"nnoremap <silent> B :call MyCapBMotion()<CR>

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


" Press * to search for the term under the cursor a visual selection and
" then <leader>r to replace all the instances in the curr file.
nnoremap <Leader>r :%s///g<Left><Left>
xnoremap <Leader>r :s///g<Left><Left>

" With asking for confirmation
nnoremap <Leader>rc :%s///gc<Left><Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Map the <Space> key to toggle a selected fold opened/closed.
nnoremap <silent> <Leader>f @=(foldlevel('.')?'za':"\<Leader>")<CR>
vnoremap <Leader>f zf

" Kube sync the currently edited file to your development pod
nnoremap <leader>ks :Start! ks % <CR>
nnoremap <leader>ss :Start! ssh_sync % <CR>


" I don't like background highlighting at all
"highlight Folded ctermbg=black
highlight Folded ctermbg=NONE ctermfg=10


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

augroup vimwikipsave
    autocmd!
    autocmd BufWritePost */tools/private-wiki/** execute ':silent ! cd ~/tools/private-wiki && nohup $(if git rev-parse --git-dir > /dev/null 2>&1 ; then git add . && git commit -m "Auto-commit: saved %" && git push; fi > /dev/null 2>&1) &'
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

  autocmd BufWinLeave *.vimrc normal! mC
  autocmd BufWinLeave *init.vim normal! mV
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

"let g:nayvy_linter_for_fix = "flake8"
let g:nayvy_import_path_format = "all_absolute"
let g:nayvy_coc_enabled = 1
let g:nayvy_import_config_path = "~/dotfiles/nayvy_config.py"

let g:ale_completion_enabled = 0
let g:ale_lint_on_enter = 0
let g:ale_fix_on_save = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_linters_explicit = 1
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_echo_msg_format = '[%linter%][%severity%]'

" let g:ale_linters = {'python': ['flake8']}

let g:ale_lint_dirs = {
\    'flake8': getcwd()
\}

let g:ale_fixers = {
\   'python': ['remove_trailing_lines', 'trim_whitespace', 'isort', 'black'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 0

:command! Json :%!python -m json.tool

let g:pythonStdlibPath = '~/.pyenv/versions/3.7.7/lib/python3.7/site-packages/'


function! RooterFileShow() abort
    :Rooter
    :f
endfunction

command! F call RooterFileShow()

"colorscheme gruvbox8
set noshowmode
set shortmess+=F
colorscheme gruvbox
"colorscheme catppuccin-mocha
let g:fzf_colors =
\ { 'fg': ['fg', 'Normal'],
\ 'bg': ['bg', 'Normal']}
hi Normal guibg=NONE ctermbg=NONE
hi Visual cterm=none ctermbg=darkgrey ctermfg=cyan
hi FloatermBorder guibg=orange guifg=cyan

highlight Folded ctermbg=NONE ctermfg=10
syntax on

let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 79,
      \ 'x': 60,
      \ 'y': 80,
      \ 'z': 45,
      \ 'warning': 2,
      \ 'error': 2,
      \ }
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z', 'error', ]
      \ ]
