return {
  { "norcalli/nvim-colorizer.lua" },
  { "akinsho/toggleterm.nvim", version = "*", config = true },
  { "nvim-tree/nvim-web-devicons" },

  require("ts_context_commentstring").setup({
    languages = {
      c = "// %s",
    },
  }),

  {
    "folke/noice.nvim",
    require("noice").setup({
      routes = {
        {
          filter = {
            event = "lsp",
            kind = "progress",
            find = "jdtls",
          },
          opts = { skip = true },
        },
      },
    }),
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      vim.lsp.enable("julials"),
    },
  },

  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
    config = function(_, opts)
      require("luasnip").setup(opts)

      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })
    end,
  },
}
