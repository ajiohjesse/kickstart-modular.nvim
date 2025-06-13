return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require "alpha"
    local dashboard = require "alpha.themes.dashboard"

    -- Get today's date in the specified format
    local function get_today_date()
      local date = os.date "*t"
      local day_names = { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" }
      local month_names = {
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December",
      }

      -- Get ordinal suffix for day
      local function get_ordinal(day)
        if day >= 11 and day <= 13 then
          return day .. "th"
        else
          local last_digit = day % 10
          if last_digit == 1 then
            return day .. "st"
          elseif last_digit == 2 then
            return day .. "nd"
          elseif last_digit == 3 then
            return day .. "rd"
          else
            return day .. "th"
          end
        end
      end

      return string.format(
        "✨ Today is %s, %s %s, %d ✨",
        day_names[date.wday],
        get_ordinal(date.day),
        month_names[date.month],
        date.year
      )
    end

    dashboard.section.header.val = {
      [[╭──────────────────────────────────────╮]],
      [[│                                      │]],
      [[│  ██████╗ ███████╗██╗  ██╗██╗  ██╗    │]],
      [[│  ██╔══██╗██╔════╝██║  ██║╚██╗██╔╝    │]],
      [[│  ██████╔╝█████╗  ███████║ ╚███╔╝     │]],
      [[│  ██╔══██╗██╔══╝  ██╔══██║ ██╔██╗     │]],
      [[│  ██║  ██║███████╗██║  ██║██╔╝ ██╗    │]],
      [[│  ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    │]],
      [[│            Jesse's Neovim            │]],
      [[╰──────────────────────────────────────╯]],
      [[]],
      get_today_date(),
    }

    dashboard.section.buttons.val = {
      dashboard.button("SPC f f", "󰈞  Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("SPC f r", "󰄉  Recent Files", "<cmd>Telescope oldfiles<CR>"),
      dashboard.button("SPC f g", "󰈬  Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("q", "󰗼  Quit", "<cmd>qa<CR>"),
    }

    local function footer()
      local quotes = {
        -- Programming Wisdom
        "💡 Code is like humor. When you have to explain it, it's bad.",
        "⚡ Simplicity is the soul of efficiency.",
        "🎯 Write code as if the next person maintaining it is a psychopath who knows where you live.",
        "✨ The best code is no code at all.",
        "🔥 Programs must be written for people to read, and only incidentally for machines to execute.",
        "💎 Clean code always looks like it was written by someone who cares.",
        "🚀 First, solve the problem. Then, write the code.",
        "⭐ Code never lies, comments sometimes do.",
        "🎨 Good code is its own best documentation.",
        "💻 Any fool can write code that a computer can understand. Good programmers write code that humans can understand.",

        -- Motivational
        "🌟 Every expert was once a beginner.",
        "💪 The only way to do great work is to love what you do.",
        "🎯 Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "🔥 Don't watch the clock; do what it does. Keep going.",
        "✨ The future belongs to those who believe in the beauty of their dreams.",
        "🚀 Keep shipping, Jesse!",
        "💎 You're not just coding, you're crafting digital art.",
        "⚡ Today's debugging is tomorrow's feature.",
        "🌈 Code with passion, debug with patience.",
        "🎨 Every bug is a puzzle waiting to be solved.",

        -- Fun/Quirky
        "☕ Coffee: The developer's fuel of choice.",
        "🐛 It's not a bug, it's an undocumented feature.",
        "🎭 There are only two hard things in Computer Science: cache invalidation and naming things.",
        "🔄 To iterate is human, to recurse divine.",
        "🎲 There are only 10 types of people: those who understand binary and those who don't.",
        "🌙 Programming is 10% writing code and 90% figuring out why it doesn't work.",
        "🎪 Welcome to the show! Today's performance: 'Why does this work in development but not production?'",
      }

      math.randomseed(os.time())
      local selected_quote = quotes[math.random(#quotes)]

      return {
        selected_quote,
      }
    end

    dashboard.section.footer.val = footer()

    -- Enhanced styling
    dashboard.section.header.opts.hl = "String"
    dashboard.section.buttons.opts.hl = "Keyword"
    dashboard.section.footer.opts.hl = "Comment"

    -- Add some spacing
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
      dashboard.section.footer,
    }

    -- Disable folding on alpha buffer
    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    -- Auto-close alpha when opening a file
    vim.api.nvim_create_autocmd("User", {
      pattern = "AlphaReady",
      desc = "Close Alpha when starting to actually edit a file",
      callback = function()
        vim.api.nvim_create_autocmd("BufRead", {
          callback = function()
            local current_buf = vim.api.nvim_get_current_buf()
            local alpha_buf = vim.fn.bufnr "Alpha"
            if current_buf ~= alpha_buf and alpha_buf ~= -1 then
              vim.api.nvim_buf_delete(alpha_buf, { force = true })
            end
          end,
        })
      end,
    })
  end,
}
