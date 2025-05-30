return {'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', 
      'nvim-tree/nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      animation = true,
       highlight_visible = true,
       gitsigns = {
        added = {enabled = true, icon = '+'},
       changed = {enabled = true, icon = '~'},
        deleted = {enabled = true, icon = '-'},
      },
      no_name_title = "untitled",
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0',
}
