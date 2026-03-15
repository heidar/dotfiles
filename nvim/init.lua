-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Leader key (must be set before lazy)
vim.g.mapleader = " "

-- Plugins
require("lazy").setup({
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      local function is_dark()
        local result = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
        return vim.trim(result) == "Dark"
      end

      local function apply_theme()
        local flavour = is_dark() and "mocha" or "latte"
        require("catppuccin").setup({ flavour = flavour })
        vim.cmd.colorscheme("catppuccin-" .. flavour)
      end

      apply_theme()

      -- Re-check every 3 seconds
      vim.fn.timer_start(3000, apply_theme, { ["repeat"] = -1 })
    end,
  },
})

-- Editor options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
