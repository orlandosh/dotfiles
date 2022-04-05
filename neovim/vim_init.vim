" General settings
colorscheme onedark
let g:onedark_termcolors=16
let g:rainbow_active = 1

syntax on
highlight Comment gui=italic
setlocal spell spelllang=en_us
set spell spelllang=en_us
set noshowmode
set completeopt=menu,menuone,noselect
set number
set relativenumber
set termguicolors
set modifiable

" for when the time comes
" set laststatus=3

" REMAPS
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <leader>b <cmd>CHADopen<cr>
nnoremap <leader>sv <cmd>source $MYVIMRC<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>t <cmd>Telescope lsp_dynamic_workspace_symbols<cr>
nnoremap <leader>tr <cmd>TroubleToggle<cr>

" Clear highlighting on escape in normal mode
nnoremap <esc> <cmd>noh<cr><esc>
nnoremap <esc>^[ <esc>^[

" TODO: show chadtree on the right
" TODO: ignore spellcheck on file extensions
let g:chadtree_settings = { "theme.icon_glyph_set": "ascii", "keymap.open_sys": [], "keymap.primary": ["o", "<enter>"], "keymap.tertiary": ["O", "<m-enter>", "middlemouse"] }

" format on save
autocmd BufWritePre *.py,*.lua lua vim.lsp.buf.formatting_sync(nil, 1000)
" lint on save
autocmd BufWritePost *.py lua require('lint').try_lint()

