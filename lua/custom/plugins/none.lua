if true then return {} end

-- plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require "null-ls" -- alias still used
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local helpers = require "null-ls.helpers"

    local biome_config_exists = function(utils)
      return utils.root_has_file { "biome.json", "biome.jsonc", ".biomerc.json" }
    end

    local eslint_config_exists = function(utils)
      return utils.root_has_file {
        ".eslintrc.js",
        ".eslintrc.json",
        ".eslintrc.cjs",
        ".eslintrc.yml",
        ".eslintrc.yaml",
      }
    end

    local prettier_config_exists = function(utils)
      return utils.root_has_file {
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.json",
        ".prettierrc.yml",
        "prettier.config.js",
      }
    end

    null_ls.setup {
      sources = {
        -- Lua
        formatting.stylua,

        -- Go
        formatting.gofmt,
        diagnostics.golangci_lint,

        -- PHP
        formatting.phpcsfixer,

        -- HTML
        formatting.prettier.with {
          condition = prettier_config_exists,
          filetypes = { "html" },
        },

        -- JavaScript / TypeScript
        formatting.prettier.with {
          condition = function(utils) return prettier_config_exists(utils) and not biome_config_exists(utils) end,
          filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
        },
        diagnostics.eslint.with {
          condition = function(utils) return eslint_config_exists(utils) and not biome_config_exists(utils) end,
        },
        -- require("null-ls").builtins.code_actions.eslint.with {
        --   condition = function(utils) return eslint_config_exists(utils) and not biome_config_exists(utils) end,
        -- },

        -- Biome: used if a biome config exists
        formatting.biome.with {
          condition = biome_config_exists,
        },
        diagnostics.biome.with {
          condition = biome_config_exists,
        },
      },
    }
  end,
}
