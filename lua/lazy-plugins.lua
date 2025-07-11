require("lazy").setup({
  "NMAC427/guess-indent.nvim",
  require "kickstart/plugins/gitsigns",
  require "kickstart/plugins/which-key",
  require "kickstart/plugins/telescope",
  require "kickstart/plugins/lspconfig",
  require "kickstart/plugins/cmp",
  require "kickstart/plugins/conform",
  require "kickstart/plugins/themes",
  require "kickstart/plugins/todo-comments",
  require "kickstart/plugins/mini",
  require "kickstart/plugins/treesitter",
  require "kickstart/plugins/indent_line",
  require "kickstart/plugins/lint",
  require "kickstart/plugins/autopairs",
  require "kickstart/plugins/neo-tree",
  { import = "custom.plugins" },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
