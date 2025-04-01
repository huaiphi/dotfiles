local opt = vim.opt

vim.cmd("set nofsync")

opt.splitright = true;
opt.splitbelow = true;

opt.mouse = "a"

opt.autoindent = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.cursorlineopt = "number"
opt.signcolumn = "yes"
opt.showmode = false

opt.colorcolumn = "80"

opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.syntax = "on"
opt.termguicolors = true

opt.ignorecase = true
opt.hlsearch = true

opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
