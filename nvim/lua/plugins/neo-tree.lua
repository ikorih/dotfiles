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
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        window = {
          mappings = {
            ["o"] = "open",
          },
        },
      },
      window = {
        mappings = {},
      },
    },
  },
}
