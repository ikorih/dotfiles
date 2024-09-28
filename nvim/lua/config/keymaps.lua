-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { silent = true }

-- "x"を押したときに文字を削除してもヤンク（コピー）レジスタに保存されないようにする
keymap.set("n", "x", '"_x')

-- <Leader>pを押したときに"0"（ヤンクレジスタ）から貼り付けを行う
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')

-- <Leader>cを押したときに"c"コマンドを使用しても削除内容がヤンクレジスタに保存されないようにする
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')

-- <Leader>dを押したときに"d"コマンドを使用しても削除内容がヤンクレジスタに保存されないようにする
keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- 新しいタブを開くためのキー設定（"te"で新しいタブを開く）
keymap.set("n", "te", ":tabedit")

-- Tabキーで次のタブに移動し、Shift+Tabで前のタブに戻る
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- ウィンドウを横に分割する（ss）および縦に分割する（sv）
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Ctrl+wと矢印キーでウィンドウサイズをリサイズする
keymap.set("n", "<C-w><left>", "<C-w><") -- 左にウィンドウサイズを縮小
keymap.set("n", "<C-w><right>", "<C-w>>") -- 右にウィンドウサイズを拡大
keymap.set("n", "<C-w><up>", "<C-w>+") -- 上にウィンドウサイズを拡大
keymap.set("n", "<C-w><down>", "<C-w>-") -- 下にウィンドウサイズを縮小

-- 挿入モードで"jk"を押すことでノーマルモードに戻る
keymap.set("i", "jk", "<ESC>", opts)
