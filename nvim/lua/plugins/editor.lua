return {
  {
    --[[
    概要:
    vim-expand-regionは、ビジュアルモードで選択範囲を拡大・縮小するためのプラグインです。
    単語、括弧、段落などのテキストオブジェクトを基準に範囲を動的に調整できます。

    使用方法:
    1. ビジュアルモードで"v"キーを押して選択モードに入る。
    2. "v"キーを押すごとに選択範囲が拡大。
    3. "V"キーを押すと選択範囲が縮小。

    カスタマイズ:
    以下の`expand_region_text_objects`で拡大・縮小時の対象テキストオブジェクトを調整可能。
    ]]
    "terryma/vim-expand-region",
    event = "VeryLazy",
    keys = {
      { "v", mode = { "x" }, "<Plug>(expand_region_expand)", desc = "expand_region_expand" }, -- 選択範囲を拡大
      { "V", mode = { "x" }, "<Plug>(expand_region_shrink)", desc = "expand_region_shrink" }, -- 選択範囲を縮小
    },
    init = function()
      vim.cmd([[
            let g:expand_region_text_objects = {
            \ 'iw'  :0,
            \ 'iW'  :0,
            \ 'i"'  :0,
            \ 'i''' :0,
            \ 'i]'  :1,
            \ 'ib'  :1,
            \ 'iB'  :1,
            \ 'il'  :1,
            \ 'ii'  :1,
            \ 'ip'  :0,
            \ 'ie'  :0,
            \ }
            ]])
    end,
  },

  {
    --[[
    概要:
    nvim-surroundは、テキストの周囲に括弧や引用符を簡単に追加・削除・変更できるプラグインです。
    Vimの "vim-surround" をベースにした進化版で、高速かつ拡張性があります。

    使用方法:
    1. 追加: 通常モードで `ys<motion><char>` 
       例: `ysiw"` → カーソル位置の単語をダブルクォートで囲む
    2. 削除: 通常モードで `ds<char>`
       例: `ds"` → ダブルクォートを削除
    3. 置換: 通常モードで `cs<char1><char2>`
       例: `cs"'` → ダブルクォートをシングルクォートに置換
    4. ビジュアルモード: 選択後に `S<char>` で囲みを追加
       例: 選択範囲をダブルクォートで囲む場合、`S"`
    ]]
    "kylechui/nvim-surround",
    version = "*", -- 安定バージョンを使用。最新機能が必要ならこの行を省略して `main` ブランチを使用
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  {

    --[[
    概要:
    この設定はnvim-lspconfigを使用してESLintを統合するものです。
    LazyVimフレームワークを活用し、ESLintによる診断とフォーマットを効率的に管理します。
    また、Neovimのバージョンに応じて動作を切り替え、古いバージョンでも対応可能。

    使用方法:
    - プロジェクト内に`.eslintrc`ファイルを配置することで、ESLintが有効化されます。
    - LazyVimのフォーマット機能を使用して`:Format`コマンドでESLintのフォーマットを実行可能。
    - Neovim 0.10.0未満では`EslintFixAll`が代わりに使用されます。
    ]]
    --
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
            workingDirectories = { mode = "auto" },
          },
        },
      },
      setup = {
        eslint = function()
          local function get_client(buf)
            return LazyVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = LazyVim.lsp.formatter({
            name = "eslint: lsp",
            primary = false,
            priority = 200,
            filter = "eslint",
          })

          -- Use EslintFixAll on Neovim < 0.10.0
          if not pcall(require, "vim.lsp._dynamic") then
            formatter.name = "eslint: EslintFixAll"
            formatter.sources = function(buf)
              local client = get_client(buf)
              return client and { "eslint" } or {}
            end
            formatter.format = function(buf)
              local client = get_client(buf)
              if client then
                local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                if #diag > 0 then
                  vim.cmd("EslintFixAll")
                end
              end
            end
          end

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
      },
    },
  },

  {
    -- Neovim のタブバーやバッファラインを操作
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      --[[
    概要:
    bufferline.nvim は、タブバーやバッファラインを視覚的に表示・操作するプラグインです。

    使用方法:
    - <Tab>: 次のバッファに移動
    - <S-Tab>: 前のバッファに移動
    ]]
      --

      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs", -- タブモードで動作
        show_buffer_close_icons = false, -- バッファ閉じるアイコンを非表示
        show_close_icon = false, -- 全体の閉じるアイコンを非表示
      },
    },
  },
}
