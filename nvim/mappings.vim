nnoremap <Space> <NOP>
vnoremap <Space> <NOP>
let mapleader = (' ')

" New splits
nmap <leader>s :split<CR>
nmap <leader>v :vsplit<CR>

" Lf
let g:lf_map_keys = 0
map <C-p> :Lf<CR>

" Fzf mappings
nnoremap <C-g> :Rg<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap <leader>e :Buffers<CR>
nnoremap <leader>h :History<CR>

" Markdown Clipboard Image
autocmd FileType markdown nmap <buffer><silent> <leader><leader>p :call mdip#MarkdownClipboardImage()<CR>

" Instant Markdown
map <leader>md :InstantMarkdownPreview<CR>

" NERDCommenter
vmap <leader>c <plug>NERDCommenterToggle
nmap <leader>c <plug>NERDCommenterToggle




