-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

--- 特定のファイル形式でconceallevel（文字の隠し表示）を無効化する設定
-- LazyVimのデフォルトではconceallevelが3に設定されていますが、この設定では
-- JSONやMarkdownファイルではconceallevelを0（文字を隠さない）に変更します- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})

-- -- phpファイルでのインデントとフォーマットの設定
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "php",
--   callback = function()
--     -- 標準インデントと衝突させない
--     vim.bo.indentexpr = ""
--
--     local cwd = vim.fn.getcwd()
--     local cmd = nil
--     if vim.fn.executable(cwd .. "/vendor/bin/phpcbf") == 1 then
--       cmd = cwd .. "/vendor/bin/phpcbf"
--     elseif vim.fn.executable(vim.fn.stdpath("data") .. "/mason/bin/phpcbf") == 1 then
--       cmd = vim.fn.stdpath("data") .. "/mason/bin/phpcbf"
--     elseif vim.fn.executable("phpcbf") == 1 then
--       cmd = "phpcbf"
--     end
--     if cmd then
--       vim.bo.equalprg = cmd .. " --stdin-path=% -"
--     end
--   end,
-- })

--- MarkdownとMDXファイルでTree-sitterを有効化する設定
--- これにより、これらのファイル形式で構文解析が改善されます
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "mdx" },
  callback = function(args)
    pcall(vim.treesitter.start, args.buf, "markdown")
    pcall(vim.treesitter.start, args.buf, "markdown_inline")
  end,
})
