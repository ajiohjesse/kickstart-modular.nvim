if true then return {} end

local config = function()
  require("lspkind").init {
    mode = "symbol_text",
    preset = "default",
    symbol_map = {
      Text = "", -- nf-cod-symbol_string
      Method = "", -- nf-cod-symbol_method
      Function = "󰊕", -- nf-md-function_variant
      Constructor = "", -- nf-fa-wrench
      Field = "", -- nf-cod-symbol_field
      Variable = "", -- nf-cod-symbol_variable
      Class = "", -- nf-cod-symbol_class
      Interface = "", -- nf-fa-sitemap
      Module = "", -- nf-cod-symbol_module
      Property = "", -- nf-cod-symbol_property
      Unit = "", -- nf-oct-package
      Value = "", -- nf-cod-symbol_enum
      Enum = "", -- nf-fa-list
      Keyword = "", -- nf-cod-symbol_keyword
      Snippet = "", -- nf-md-content_cut
      Color = "", -- nf-cod-symbol_color
      File = "", -- nf-cod-symbol_file
      Reference = "", -- nf-cod-references
      Folder = "", -- nf-cod-folder
      EnumMember = "", -- nf-fa-list
      Constant = "", -- nf-cod-symbol_constant
      Struct = "", -- nf-cod-symbol_structure
      Event = "", -- nf-fa-bolt
      Operator = "", -- nf-cod-symbol_operator
      TypeParameter = "", -- nf-cod-symbol_type_parameter
      Copilot = "", -- GitHub Copilot logo
    },
  }
end

return {
  "onsails/lspkind-nvim",
  config = config,
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/nvim-cmp",
  },
}
