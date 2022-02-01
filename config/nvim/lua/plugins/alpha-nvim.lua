local alpha = require "alpha"
local dashboard = require "alpha.themes.dashboard"

local function footer()
  local datetime = os.date("%Y/%m/%d %H:%M:%S")
  return datetime
end

dashboard.section.header.val = {
  "                                                    ",
  " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
  "                                                    ",
}

dashboard.section.buttons.val = {
  dashboard.button("e", " New file", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", " Find file", "<cmd>lua require('fzf-lua').files()<CR>"),
  dashboard.button("s", " Settings", ":e $MYVIMRC<CR>"),
  dashboard.button("u", " Update plugins", ":PackerUpdate<CR>"),
  dashboard.button("q", " Quit", ":qa<CR>"),
}

dashboard.section.footer.val = footer()

require("alpha").setup(dashboard.config)
