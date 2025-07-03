-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { silent = true }

-- "x"を押したときに文字を削除してもヤンク（コピー）レジスタに保存されないようにする
keymap.set("n", "x", '"_x')

-- 新しいタブを開くためのキー設定（"te"で新しいタブを開く）
keymap.set("n", "te", ":tabedit")

-- Tabキーで次のタブに移動し、Shift+Tabで前のタブに戻る
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- 挿入モードで"jk"を押すことでノーマルモードに戻る
keymap.set("i", "jk", "<ESC>", opts)
keymap.set("i", "jj", "<ESC>", opts)

-- <C-t> を <leader>ff と同じ動作に設定
keymap.set("n", "<C-t>", function()
  require("fzf-lua").files()
end, { desc = "Find Files (same as <leader>ff)", silent = true })
