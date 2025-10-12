return {
  "saghen/blink.cmp",
  -- LazyVim の blink エクストラが既に読み込んでいる前提で、上書きだけ行う
  opts = function(_, opts)
    opts.keymap = opts.keymap or {}
    opts.keymap.preset = "default"
  end,
}
