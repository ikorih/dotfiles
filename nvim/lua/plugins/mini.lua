return {
  -- mini.align の設定
  {
    "nvim-mini/mini.align",
    keys = { "ga", "gA" }, -- 整列コマンドにキーバインドを割り当て
    event = "VeryLazy",
    config = function()
      --[[
      概要:
      mini.align は、テキストの整列を行うプラグインです。
      カスタム分割文字やパターンに基づいて、テキストを整列できます。

      使用方法:
      - `ga`: 分割文字を指定して整列。
        例: 等号（=）を指定すると次のように整列されます。
          before:
            key1=value1
            key2= value2
          after:
            key1 = value1
            key2 = value2
      - `gA`: 複数の分割文字や詳細設定を用いて整列。
      ]]
      --
      require("mini.align").setup({})
    end,
  },
  -- https://github.com/LazyVim/LazyVim/pull/1434
  -- mini.ai の設定
  {
    "nvim-mini/mini.ai",
    opts = function(_, opts)
      --[[
      概要:
      mini.ai は、Neovimのテキストオブジェクトを拡張し、カスタムテキストオブジェクトを簡単に利用可能にするプラグインです。

      使用方法:
      - 標準のテキストオブジェクトを拡張するほか、設定によりカスタムオブジェクトを定義可能です。
      - この設定では、デフォルトのタグ用テキストオブジェクトを無効化し、Neovimの標準動作に戻しています。
      ]]
      --
      opts.custom_textobjects = {
        t = false, -- タグ用テキストオブジェクトを無効化
      }
    end,
  },
}
