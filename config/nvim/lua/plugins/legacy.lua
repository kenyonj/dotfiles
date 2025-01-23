local function get_home_directory()
  local handle = io.popen("whoami")
  if handle then
    local username = handle:read("*l")
    handle:close()
    return "/home/" .. username
  end
end

local function get_dark_mode_status()
  local home_directory = get_home_directory()
  local status_file = home_directory .. "/.dark_mode_status.txt"
  local file = io.open(status_file, "r")
  if file then
    local status = file:read("*l"):match("^%s*(.-)%s*$")
    file:close()
    return status
  end
  return nil
end

return {
  { 'tpope/vim-eunuch',          lazy = false },
  { 'tpope/vim-rails',           lazy = false },
  { 'tpope/vim-repeat',          lazy = false },
  { 'tpope/vim-rhubarb',         lazy = false },
  { 'tpope/vim-surround',        lazy = false },
  { 'tpope/vim-vinegar',         laze = false },
  { 'tpope/vim-projectionist',   lazy = false },

  -- Workflow
  { 'sjl/gundo.vim',             lazy = false },

  -- Searching
  { 'RRethy/vim-illuminate',     lazy = false },
  { 'mhinz/vim-grepper',         lazy = false },

  -- Languages and markup
  { 'sheerun/vim-polyglot',      lazy = false },

  -- Colors / Theme
  { 'gruvbox-community/gruvbox', lazy = false },
  { 'sainnhe/gruvbox-material',  lazy = false },
  { 'sainnhe/sonokai',           lazy = false },
  { 'sainnhe/everforest',        lazy = false },
  { 'catppuccin/vim',            lazy = false },
  { 'folke/tokyonight.nvim',     lazy = false },
  { 'rose-pine/neovim',          lazy = false },
  { 'ellisonleao/gruvbox.nvim',  lazy = false },
  {
    'f-person/auto-dark-mode.nvim',
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        local dark_mode = get_dark_mode_status()
        vim.cmd("colorscheme gruvbox")

        if dark_mode ~= "off" then
          vim.api.nvim_set_option_value("background", "dark", {})
        end
      end,
      set_light_mode = function()
        local dark_mode = get_dark_mode_status()
        vim.cmd("colorscheme gruvbox")

        if dark_mode == "off" then
          vim.api.nvim_set_option_value("background", "light", {})
        end
      end,
    },
  },

  -- writing
  { 'junegunn/goyo.vim',         lazy = false },

  { 'nvim-lua/plenary.nvim',     lazy = false },
}
