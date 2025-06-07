return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"

  
    dashboard.section.header.val = {
      [[ ██████╗ ███████╗██╗  ██╗██╗  ██╗ ]],
      [[ ██╔══██╗██╔════╝██║  ██║╚██╗██╔╝ ]],
      [[ ██████╔╝█████╗  ███████║ ╚███╔╝  ]],
      [[ ██╔══██╗██╔══╝  ██╔══██║ ██╔██╗  ]],
      [[ ██║  ██║███████╗██║  ██║██╔╝ ██╗ ]],
      [[ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ]],
      [[        🚀 Jesse's Neovim 🚀        ]],
    }

    -- Menu Buttons
    dashboard.section.buttons.val = {
      dashboard.button("f", "󰈞  Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("s", "  Restore session", ":lua require('persistence').load()<CR>"),
      dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
      dashboard.button("q", "󰗼  Quit", ":qa<CR>"),
    }

    -- Footer with random quote
    local function footer()
      local quotes = {
        "Code is like humor. When you have to explain it, it’s bad.",
        "Simplicity is the soul of efficiency.",
        "Write code as if the next person maintaining it is a psychopath who knows where you live.",
        "The best code is no code at all.",
        "🚀 Keep shipping, Jesse!",
      }
      math.randomseed(os.time())
      return quotes[math.random(#quotes)]
    end

    dashboard.section.footer.val = footer()

    -- Style
    dashboard.section.header.opts.hl = "Include"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)
  end,
}
