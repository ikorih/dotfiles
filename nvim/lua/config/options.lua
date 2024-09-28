-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.mouse = ""
-- vim.opt.wrap = true
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true

vim.opt.wrap = true

-- Set filetype for nunjucks files
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, { pattern = "*.njk", command = "set filetype=html" })
