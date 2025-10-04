return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "VeryLazy",
  config = function()
    require("copilot").setup({
      panel = {
        enabled = true,
        auto_refresh = true,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-m>",
        },
        layout = { position = "bottom", ratio = 0.4 },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<M-CR>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
        zsh = false,
        sh = function()
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
            return false
          end
          if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.zsh_history.*") then
            return false
          end
          return true
        end,
      },
      copilot_node_command = "node",
      server_opts_overrides = {
        trace = "verbose",
        advanced = { listCount = 10, inlineSuggestionCount = 10 },
      },
    })
  end,
}

