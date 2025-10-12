-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.mouse = ""
-- vim.opt.wrap = true
-- vim.opt.autoindent = true
-- vim.opt.smartindent = true

vim.opt.wrap = true

-- Set filetype for nunjucks files
vim.api.nvim_create_autocmd(
  { "BufNewFile", "BufRead" },
  { pattern = { "*.njk", "*.hbs" }, command = "set filetype=html" }
)

vim.g.snacks_animate = false

vim.g.lazyvim_mini_snippets_in_completion = true

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = true

-- Enable automatic formatting on save for ESLint
vim.g.lazyvim_eslint_auto_format = true

-- LSP Server to use for PHP.
-- Set to "intelephense" to use intelephense instead of phpactor.
-- vim.g.lazyvim_php_lsp = "intelephense"
