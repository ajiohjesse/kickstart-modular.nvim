if true then return {} end

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    version = "1.*",
    dependencies = {
      "hrsh7th/nvim-cmp",
      {
        "L3MON4D3/LuaSnip",
        version = "2.*",
        build = (function()
          if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then return end
          return "make install_jsregexp"
        end)(),
        dependencies = {
          --   {
          --     "rafamadriz/friendly-snippets",
          --     config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
          --   },
          -- },
          opts = {},
        },
        "folke/lazydev.nvim",
      },

      --- @type blink.cmp.Config
      opts = {
        keymap = {
          preset = "enter",
        },
        appearance = {
          nerd_font_variant = "mono",
          menu = { enabled = true },
        },
        completion = {
          documentation = { auto_show = true, auto_show_delay_ms = 500 },
          menu = { enabled = true },
        },
        sources = {
          -- default = { "lsp", "path", "snippets", "lazydev", "buffer" },
          default = { "lsp", "path", "lazydev" },
          providers = { lazydev = { module = "lazydev.integrations.blink", score_offset = 100 } },
        },
        -- snippets = { preset = "luasnip" },
        fuzzy = { implementation = "lua" },
        signature = { enabled = true },
        sorting = {
          priority_weight = 2,
          comparators = {
            -- We will fill this in config function
          },
        },
      },
      config = function(_, opts)
        local cmp = require "cmp"
        -- Assign comparators here, since cmp must be loaded first
        opts.sorting.comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        }
        require("blink.cmp").setup(opts)
      end,
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
