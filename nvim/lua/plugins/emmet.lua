return {
  -- https://github.com/LazyVim/LazyVim/pull/1434
  {
    "mattn/emmet-vim",
    event = { "BufRead", "BufNewFile" }, -- ファイルを開いたときや新規作成時に遅延ロード
    init = function()
      --[[
      概要:
      emmet-vimは、HTMLやCSSなどのマークアップ言語のコーディングを高速化するプラグインです。
      簡略化した構文を入力することで、複雑なコードを即座に展開できます。

      使用方法:
      - リーダーキー（ここでは `Ctrl + e`）を使用してEmmetコマンドを実行します。

      リーダーキー + コマンド:
      - `<C-e>,` : Emmet展開を実行
      ]]
      --
      vim.g.user_emmet_leader_key = "<C-e>" -- Control+e+,に設定
      vim.g.user_emmet_settings = {
        php = {
          extends = "html", -- PHPファイルではHTMLの構文を使用
        },
      }
    end,
  },
}
