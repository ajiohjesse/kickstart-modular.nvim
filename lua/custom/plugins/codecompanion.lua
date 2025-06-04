return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "j-hui/fidget.nvim",
    "ravitemer/codecompanion-history.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
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
        -- Read the API key from an environment variable
        local gemini_api_key = vim.env.GEMINI_API_KEY

        -- Check if the environment variable is set
        if not gemini_api_key or gemini_api_key == "" then error "GEMINI_API_KEY environment variable is not set!" end

        return require("codecompanion.adapters").extend("gemini", {
          env = {
            -- Use the value from the environment variable
            api_key = gemini_api_key,
          },
        })
      end,
    },
    keys = {
      { "<leader>i", "", desc = "AI" },
      { "<leader>ic", "<cmd>CodeCompanion<cr>", desc = "CodeCompanion" },
      { "<leader>iC", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
      { "<leader>ia", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      { "<leader>id", "<cmd>CodeCompanionCmd<cr>", desc = "CodeCompanion CMD" },
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
  },
}
