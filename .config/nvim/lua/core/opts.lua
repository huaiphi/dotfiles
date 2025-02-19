local opt = vim.opt

vim.cmd("set nofsync")

opt.wildignorecase = true

opt.hidden = true
opt.autowrite = true

opt.splitright = true;
opt.splitbelow = true;

opt.foldmethod = "manual"

opt.showmode = false

opt.mouse = "a"

opt.autoindent = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"

opt.colorcolumn = "80"

opt.scrolloff = 4
opt.clipboard = "unnamedplus"
opt.inccommand = "nosplit"
opt.encoding = "utf8"
opt.fileencoding = "utf8"
opt.swapfile = false
opt.syntax = "on"
opt.termguicolors = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
