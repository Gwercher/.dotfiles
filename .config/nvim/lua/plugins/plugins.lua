return {
  { "norcalli/nvim-colorizer.lua" },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { "nvim-tree/nvim-web-devicons" },

  require("ts_context_commentstring").setup({
    languages = {
      c = "// %s",
    },
  }),
}
