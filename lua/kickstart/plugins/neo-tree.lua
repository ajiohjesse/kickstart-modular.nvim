return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  config = function()
    require("neo-tree").setup {
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = "right",
        width = 30,
        mappings = {
          ["<cr>"] = "open",
          ["l"] = "open",
          ["h"] = "close_node",
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
        hijack_netrw_behavior = "open_current",
      },
    }

    -- Toggle Neo-tree
    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })

    vim.keymap.set("n", "\\", function()
      local current_buf = vim.api.nvim_get_current_buf()
      local buf_ft = vim.bo[current_buf].filetype

      if buf_ft == "neo-tree" then
        -- Focus previous window (usually your file buffer)
        vim.cmd "wincmd p"
      else
        -- Focus Neo-tree (will open if it's not visible)
        vim.cmd "Neotree focus"
      end
    end, { desc = "Toggle focus between Neo-tree and file buffer" })
  end,
}
