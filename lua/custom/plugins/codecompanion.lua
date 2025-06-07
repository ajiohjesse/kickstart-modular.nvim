return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
    "ravitemer/codecompanion-history.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "codecompanion" },
    },
  },
  opts = {
    extensions = {
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          auto_generate_title = true,
          continue_last_chat = false,
          delete_on_clearing_chat = false,
          picker = "snacks",
          enable_logging = false,
          dir_to_save = vim.fn.stdpath "data" .. "/codecompanion-history",
        },
      },
    },
    adapters = {
      gemini = function()
        local gemini_api_key = vim.env.GEMINI_API_KEY
        if not gemini_api_key or gemini_api_key == "" then error "GEMINI_API_KEY environment variable is not set!" end

        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-2.0-flash-lite",
            },
          },
          env = {
            api_key = gemini_api_key,
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
      cmd = {
        adapter = "gemini",
      },
    },
    display = {
      diff = {
        provider = "mini_diff",
      },
    },
  },
}
