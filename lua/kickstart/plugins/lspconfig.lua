-- Enable biome LSP globally
-- vim.lsp.enable "biome"

return {
  {
    -- Lua LSP for Neovim config, runtime, and plugins
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "mason-org/mason-lspconfig.nvim",
      {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
          ensure_installed = {
            -- LSP servers
            "lua-language-server",
            "tailwindcss-language-server",
            "typescript-language-server",
            "eslint",
            "html",
            "cssls",
            "emmet_ls",
            "jsonls",
            "biome",

            -- Formatters
            "stylua",
            "prettier",

            -- Other tools
            "tree-sitter-cli",
          },
        },
      },
      { "j-hui/fidget.nvim", opts = {} }, -- LSP status updates
      "saghen/blink.cmp", -- Enhanced LSP capabilities for completion
    },
    config = function()
      -- Keymaps for LSP features on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local buf = event.buf
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
          end

          map("gR", vim.lsp.buf.rename, "Rename")
          map("ga", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
          map("glr", require("telescope.builtin").lsp_references, "References")
          map("gli", require("telescope.builtin").lsp_implementations, "Implementations")
          map("gd", require("telescope.builtin").lsp_definitions, "Definitions")
          map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
          map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
          map("glt", require("telescope.builtin").lsp_type_definitions, "Type Definitions")

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method and client:supports_method "textDocument/documentHighlight" then
            local hl_group = vim.api.nvim_create_augroup("lsp-document-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = buf,
              group = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = buf,
              group = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
              callback = function(ev)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = "lsp-document-highlight", buffer = ev.buf }
              end,
            })
          end
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        virtual_text = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN] = "WarningMsg",
          },
        },
      }

      -- Enhanced LSP capabilities for completion
      -- local capabilities = require("blink.cmp").get_lsp_capabilities()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- LSP servers configuration
      local servers = {
        gopls = {},
        ts_ls = {},
        tailwindcss = {},
        emmet_ls = {
          filetypes = { "html", "typescriptreact", "javascriptreact", "css", "scss" },
        },
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        biome = {}, -- biome LSP config
        eslint = {}, -- eslint LSP for linting JS/TS
        html = {},
        cssls = {},
        jsonls = {},
      }

      -- Ensure Mason installs all servers and formatters
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { "stylua" })

      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      require("mason-lspconfig").setup {
        ensure_installed = {}, -- handled by mason-tool-installer
        automatic_installation = false,
        automatic_enable = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end,
        },
      }
    end,
  },
} -- vim: ts=2 sts=2 sw=2 et
