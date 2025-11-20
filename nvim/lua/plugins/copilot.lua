return {
  {
    -- LazyVim の Copilot extra は zbirenbaum/copilot.lua を使います
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true, -- ゴーストを自動表示
        -- Tab 競合を避けるため、明示的に別キーを割り当て
        keymap = {
          accept = "<C-y>", -- 提案を受け入れ（おすすめ）
          accept_word = "<M-w>", -- 単語単位で受け入れ
          accept_line = "<M-l>", -- 行単位で受け入れ
          next = "<M-]>", -- 次の提案
          prev = "<M-[>", -- 前の提案
          dismiss = "<C-]>", -- 提案を閉じる
        },
      },
      panel = { enabled = false },
    },
  },

  -- blink.cmp 併用時のフォールバック（任意）
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- すでに `opts.keymap.preset = "default"` を使っているので、
      -- こちらでは Copilot と被らない <C-y> を “AI優先→補完” にする例
      local function accept_ai_or_confirm()
        local ok, sugg = pcall(require, "copilot.suggestion")
        if ok and sugg.is_visible() then
          sugg.accept()
          return
        end
        -- 補完メニューが出ていれば confirm、無ければ改行など好みの動作へ
        local ok2, blink = pcall(require, "blink.cmp")
        if ok2 and blink.is_visible() then
          blink.accept()
        else
          -- 何もしない/改行など好みに応じて
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", true)
        end
      end

      opts.keymap = opts.keymap or {}
      opts.keymap["<C-y>"] = { "select_and_accept", accept_ai_or_confirm }
    end,
  },
}
