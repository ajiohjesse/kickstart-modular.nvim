return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    animation = true,
    highlight_visible = true,
    gitsigns = {
      added = { enabled = true, icon = "+" },
      changed = { enabled = true, icon = "~" },
      deleted = { enabled = true, icon = "-" },
    },
    icons = {
      filetype = {
        -- Sets the icon's highlight group.
        -- If false, will use nvim-web-devicons colors
        custom_colors = true,
        -- Requires `nvim-web-devicons` if `true`
        enabled = true,
      },
    },
    no_name_title = "untitled",
    -- insert_at_start = true,
    -- …etc.
  },
  version = "^1.0.0",
}
