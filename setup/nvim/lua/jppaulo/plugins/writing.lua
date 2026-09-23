return {
  {
    "lervag/vimtex",
    tag = "v2.17", -- Supports this machine's Neovim 0.10.4.
    lazy = false, -- Inverse search needs the global VimtexInverseSearch command.
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_quickfix_mode = 0 -- Open errors explicitly with Space l e.
      if vim.env.TMUX_PANE and vim.fn.executable("tmux") == 1 then
        vim.api.nvim_create_autocmd("User", {
          group = vim.api.nvim_create_augroup("WritingTmuxInverseSearch", { clear = true }),
          pattern = "VimtexEventViewReverse",
          callback = function()
            -- The callback executes in the original editor, so TMUX_PANE
            -- identifies its pane even when the PDF viewer is outside tmux.
            vim.fn.jobstart({ "tmux", "select-window", "-t", vim.env.TMUX_PANE,
              ";", "select-pane", "-t", vim.env.TMUX_PANE })
          end,
        })
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-omni",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- VimTeX supplies LaTeX highlighting, spelling regions, and indentation.
      -- Preserve the existing rules for other programming languages.
      for _, feature in ipairs({ "highlight", "indent" }) do
        opts[feature] = opts[feature] or {}
        local previous = opts[feature].disable
        opts[feature].disable = function(lang, buf)
          if lang == "latex" then
            return true
          end
          if type(previous) == "function" then
            return previous(lang, buf)
          end
          return type(previous) == "table" and vim.tbl_contains(previous, lang) or false
        end
      end
    end,
  },
}
