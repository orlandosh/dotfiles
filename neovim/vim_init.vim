let g:lightline = {
        \ 'active': {
        \ 'left': [ ['mode', 'paste'],
        \           ['readonly', 'filename', 'modified', 'fugitive'] ]
        \ },
        \ 'colorscheme': 'onedark',
        \ 'component_function': {
        \     'fugitive': 'fugitive#head'
        \ },
        \ }

" General settings
colorscheme onedark
let g:onedark_termcolors=16
" hi! Normal guibg=NONE
" hi! NonText guibg=NONE

syntax on
highlight Comment gui=italic
setlocal spell spelllang=en_us
set noshowmode
set completeopt=menu,menuone,noselect
set number
set relativenumber
set termguicolors
set modifiable

" REMAPS
nnoremap <leader>b <cmd>NERDTreeToggle<cr>
nnoremap <leader>sv <cmd>source $MYVIMRC<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>t <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>tr <cmd>TroubleToggle<cr>

" NERDTREE
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:chadtree_settings = { "theme.icon_glyph_set": "ascii", "xdg": v:true }

" format on save
autocmd BufWritePre *.py '*.lua' lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWritePost *.py lua require('lint').try_lint()

