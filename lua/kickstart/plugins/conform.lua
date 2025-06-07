-- if true then return {} end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function() require("conform").format { async = true, lsp_format = "fallback" } end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 3000,
            lsp_format = "fallback",
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        -- Configure formatters for JavaScript and TypeScript files
        javascript = { "biome", "prettier" },
        javascriptreact = { "biome", "prettier" },
        typescript = { "biome", "prettier" },
        typescriptreact = { "biome", "prettier" },
        go = { "goimports", "gofmt" },
        rust = { "rustfmt" },
        -- Add other file types and their formatters here
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        vue = { "prettier" },
        svelte = { "prettier" },
        xml = { "prettier" },
      },
      formatters = {
        biome = {
          command = "biome",
          args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
          stdin = true,
          condition = function(ctx) return vim.fn.filereadable(vim.fn.getcwd() .. "/biome.json") == 1 end,
        },
        prettier = {
          command = "prettier",
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
          condition = function(ctx)
            local configs = {
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.js",
              "prettier.config.js",
              ".prettierrc.yaml",
              ".prettierrc.yml",
              "package.json", -- fallback, check if it contains a "prettier" key
            }
            for _, file in ipairs(configs) do
              local path = vim.fn.getcwd() .. "/" .. file
              if vim.fn.filereadable(path) == 1 then
                if file == "package.json" then
                  local json = vim.fn.json_decode(vim.fn.readfile(path))
                  if json and json.prettier then return true end
                else
                  return true
                end
              end
            end
            return false
          end,
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
