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
        javascript = { "biome", "biome-organize-imports" },
        javascriptreact = { "biome", "biome-organize-imports" },
        typescript = { "biome", "biome-organize-imports" },
        typescriptreact = { "biome", "biome-organize-imports" },
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
        -- Your existing biome formatter configuration
        biome = {
          command = "biome",
          args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
          stdin = true,
          -- Add this condition to check for biome.json
          condition = function(ctx) return vim.fn.findfile("biome.json", vim.fn.getcwd(), ctx.filename) ~= "" end,
        },
        -- Configure the Prettier formatter
        prettier = {
          command = "prettier",
          -- Optional: specify the command if it's not in your PATH
          -- command = "/path/to/your/prettier",
          -- Arguments that tell Prettier to format stdin and specify the file path
          args = { "--stdin-filepath", "$FILENAME" },
          stdin = true,
          -- Prettier is the default, so we don't need a specific condition here
          -- unless you want to prevent it from running in certain cases.
        },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
