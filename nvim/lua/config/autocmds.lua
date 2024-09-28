-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

--- 特定のファイル形式でconceallevel（文字の隠し表示）を無効化する設定
-- LazyVimのデフォルトではconceallevelが3に設定されていますが、この設定では
-- JSONやMarkdownファイルではconceallevelを0（文字を隠さない）に変更します- The default conceallevel is 3 in LazyVim
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown" },
  callback = function()
    vim.opt.conceallevel = 0
  end,
})
