local set = vim.opt

vim.g.onedark_termcolors = 16
vim.g.rainbow_active = 1

-- gruvbox
set.background = "dark"

vim.cmd([[
	syntax on
	colorscheme gruvbox-material
	highlight Comment gui=italic
	setlocal spell spelllang=en_ca
]])

set.showmode = false
set.completeopt = { "menu", "menuone", "noselect" }
set.number = true
set.relativenumber = true
set.termguicolors = true
set.modifiable = true
set.laststatus = 3
set.ignorecase = true
set.spell = true

-- remove X at the end
-- vim.cmd([[
-- function! MyTabLine()
--   let s = ''
--   for i in range(tabpagenr('$'))
--     " select the highlighting
--     if i + 1 == tabpagenr()
--       let s .= '%#TabLineSel#'
--     else
--       let s .= '%#TabLine#'
--     endif
--
--     " set the tab page number (for mouse clicks)
--     let s .= '%' . (i + 1) . 'T'
--
--     " the label is made by MyTabLabel()
--     let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
--   endfor
--
--   " after the last tab fill with TabLineFill and reset tab page nr
--   let s .= '%#TabLineFill#%T'
--
--   return s
-- endfunction
--
-- function! MyTabLabel(n)
--   let buflist = tabpagebuflist(a:n)
--   let winnr = tabpagewinnr(a:n)
--   return bufname(buflist[winnr - 1])
-- endfunction
--
-- set tabline=%!MyTabLine()
-- ]])
