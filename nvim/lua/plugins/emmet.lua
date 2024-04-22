-- vim.g.user_emmet_leader_key = "<C-Y>"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "jinja", "php", "vue", "scss" },
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_keymap(
      bufnr,
      "i",
      "<C-E>",
      "v:lua.emmet_expand_abbr()",
      { expr = true, noremap = true, silent = true }
    )
  end,
})

function _G.emmet_expand_abbr()
  if vim.fn["emmet#isExpandable"]() ~= "" then
    return vim.api.nvim_replace_termcodes("<Plug>(emmet-expand-abbr)", true, true, true)
  else
    -- emmetが展開可能でない場合は何もしない（nilを返す）
    return nil
  end
end

return {
  -- https://github.com/LazyVim/LazyVim/pull/1434
  {
    "mattn/emmet-vim",
    priority = 1000,
  },

  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      -- cmp の設定の一部として
      opts.mapping["<C-e>"] = cmp.mapping(function(fallback)
        if vim.fn["emmet#isExpandable"]() ~= "" then
          -- emmet#expandAbbr をトリガーするために <Plug>(emmet-expand-abbr) を送信
          vim.api.nvim_feedkeys(
            vim.api.nvim_replace_termcodes("<Plug>(emmet-expand-abbr)", true, true, true),
            "m",
            true
          )
        else
          fallback()
        end
      end, { "i", "s" })
    end,
  },
}
-- return {
--   {
--     "neovim/nvim-lspconfig",
--     opts = {
--       -- @type lspconfig.options
--       servers = {
--         emmet_ls = {
--           filetypes = {
--             "html",
--             "typescriptreact",
--             "javascriptreact",
--             "css",
--             "sass",
--             "scss",
--             "less",
--             "php",
--             "javascript",
--             "typescript",
--           },
--           init_options = {
--             html = {
--               options = {
--                 -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L26
--                 -- ["bem.enabled"] = true,
--               },
--             },
--           },
--         },
--       },
--     },
--   },
-- }
