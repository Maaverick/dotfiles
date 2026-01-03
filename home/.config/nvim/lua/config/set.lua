vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 1
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.mouse = "a"
vim.o.wrap = true
vim.o.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.wrap = true
vim.o.foldlevel = 99
vim.o.foldmethod = "indent"
vim.o.foldenable = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
vim.opt.undofile = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50
vim.o.autoread = true
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "•",
  extends = ">",
  precedes = "<",
  nbsp = "␣"
}
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#ff8800" }) -- Orange for changes
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#00ff00" })    -- Green for additions
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#ff0000" }) -- Red for deletions

-- Font settings for optimal Radical theme rendering
-- Enable true color support for best theme appearance
vim.opt.termguicolors = true

-- GUI font setting (future-proof if you use GUI Neovim clients)
vim.opt.guifont = "Hasklug Nerd Font Mono Light:h10"
