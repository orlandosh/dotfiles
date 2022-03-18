call plug#begin()
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'unblevable/quick-scope'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'voldikss/vim-floaterm'
Plug 'Pocco81/AutoSave.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'numToStr/Comment.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'lewis6991/gitsigns.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'folke/lsp-colors.nvim'
Plug 'folke/trouble.nvim'
Plug 'ray-x/lsp_signature.nvim'
Plug 'mfussenegger/nvim-lint'
Plug 'andrejlevkovitch/vim-lua-format'
call plug#end()


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

" format on save
" autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)
autocmd BufWrite *.lua call LuaFormat()
autocmd BufWritePost *.py lua require('lint').try_lint()

lua dofile('/home/me/.config/nvim/lua_stuff.lua')
