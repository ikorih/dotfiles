return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      -- { "<leader>t", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },
      -- { "<leader>T", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    },
    opts = {
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false, -- 隠しファイルを表示
          hide_gitignored = false, -- .gitignore に記載されたファイルを表示
        },
        window = {
          mappings = {
            ["o"] = "open", -- "o"でファイルを開く
          },
        },
      },
      window = {
        mappings = {}, -- ウィンドウのキーバインド（現在は未設定）
      },
    },
    --[[
    概要:
    neo-tree.nvim は、Neovimのためのファイルエクスプローラープラグインです。
    ファイルシステム、バッファ、Gitステータス、ドキュメントシンボルを統合して管理できます。

    使用方法:
    1. ファイルエクスプローラーを開く:
       - デフォルトではキーが設定されていないため、`keys` セクションのコメントアウトを解除して有効化。
       - 例: `<leader>fe` でNeoTreeを開く。
    2. 隠しファイルやGit無視ファイルを表示:
       - `hide_dotfiles` と `hide_gitignored` を `false` に設定することで常に表示。
    3. ソース切り替え:
       - ファイルシステム、バッファ、Gitステータス、ドキュメントシンボルを切り替え可能。
    ]]
    --
  },
}
