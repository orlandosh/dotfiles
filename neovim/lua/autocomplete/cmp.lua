-- TODO: obviously refactor when i have time
-- TODO: split what's about the cmp and what's from the lsps
--

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end
-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")
local cmp_common_config = {
	enabled = function()
		-- disable completion in comments
		local context = require("cmp.config.context")
		-- keep command mode completion enabled when cursor is in a comment
		if vim.api.nvim_get_mode().mode == "c" then
			return true
		else
			return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		end
	end,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
			-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	window = {
		completion = {
			border = "single",
			scrollbar = "║",
		},
		documentation = {
			border = "single",
			scrollbar = "║",
		},
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping({
			i = function(fallback)
				if cmp.visible() and cmp.get_selected_entry() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end,
			s = cmp.mapping.confirm({ select = true }),
		}), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources(
		{
			{ name = "nvim_lsp" },
			{ name = "vsnip" },
		}, -- For vsnip users.
		{ { name = "buffer" } },
		{ { name = "path" } }
	),
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
			preset = "codicons",
			before = function(entry, vim_item)
				if vim_item.menu ~= nil and vim_item.menu ~= "" then
					if vim_item.menu:len() > 10 then
						vim_item.menu = string.sub(vim_item.menu, 1, 10) .. "..."
					end
				end
				return vim_item
			end,
		}),
	},
}
-- TODO: sort autocomplete values first for scss and css
cmp.setup(cmp_common_config)

local copy_table = require("utils").copy_table
local rust_config = copy_table(cmp_common_config)
local compare = require("cmp.config.compare")
rust_config["sorting"] = {
	priority_weight = 2,
	comparators = {
		-- deprioritize `.box`, `.mut`, etc.
		require("autocomplete.rust_sorting").deprioritize_postfix,
		-- deprioritize `Borrow::borrow` and `BorrowMut::borrow_mut`
		require("autocomplete.rust_sorting").deprioritize_borrow,
		-- deprioritize `Deref::deref` and `DerefMut::deref_mut`
		require("autocomplete.rust_sorting").deprioritize_deref,
		-- deprioritize `Into::into`, `Clone::clone`, etc.
		require("autocomplete.rust_sorting").deprioritize_common_traits,
		compare.offset,
		compare.exact,
		compare.score,
		compare.recently_used,
		compare.locality,
		compare.sort_text,
		compare.length,
		compare.order,
	},
}

cmp.setup.filetype("rust", rust_config)

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, { { name = "cmdline" } }),
})
