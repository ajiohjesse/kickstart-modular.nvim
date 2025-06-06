return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup {
      filetypes = { "*" },
      user_default_options = {
        tailwind = true,
        css = true,
        mode = "background", -- "foreground" | "virtualtext"
      },
    }
  end,
}
