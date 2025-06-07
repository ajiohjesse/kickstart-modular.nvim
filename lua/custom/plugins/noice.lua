return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      progress = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
      hover = {
        enabled = true,
      },
    },
    presets = {
      bottom_search = true, -- classic bottom command line for search
      command_palette = true, -- aligns command line and popup menu
      long_message_to_split = true, -- long messages into a split
      inc_rename = true, -- integrates with inc-rename.nvim
      lsp_doc_border = true, -- adds border to LSP hover/signature
    },
    views = {
      mini = {
        timeout = 500,
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify", -- enable this to get better notifications
  },
  config = function(_, opts)
    require("noice").setup(opts)

    -- Optional notify setup
    require("notify").setup {
      merge_duplicates = true,
      timeout = 500,
      background_colour = "#1e1e2e",
      render = "default",
      stages = "fade",
    }

    vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Notifications" })
  end,
}
