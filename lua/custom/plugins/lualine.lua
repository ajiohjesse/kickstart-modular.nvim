return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    sections = {
      lualine_a = {
        "mode",
        {
          function()
            local rec = vim.fn.reg_recording()
            if rec == "" then return "" end
            return "Recording @" .. rec
          end,
        },
      },
    },
  },
}
