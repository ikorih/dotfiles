return {
  -- https://github.com/LazyVim/LazyVim/pull/1434
  {
    "echasnovski/mini.ai",
    opts = function(_, opts)
      opts.custom_textobjects = {
        t = false, -- fallback to neovim for tags
      }
    end,
  },
}
