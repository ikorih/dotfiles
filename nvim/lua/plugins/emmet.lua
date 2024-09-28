return {
  -- https://github.com/LazyVim/LazyVim/pull/1434
  {
    "mattn/emmet-vim",
    event = { "BufRead", "BufNewFile" },
    init = function()
      vim.g.user_emmet_leader_key = "<C-e>" -- Control+e+,に設定
      vim.g.user_emmet_settings = {
        php = {
          extends = "html",
        },
      }
    end,
  },
}
