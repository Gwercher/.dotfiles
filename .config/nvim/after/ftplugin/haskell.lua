local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

local file = vim.fn.expand("%:p")

map(
  "n",
  "<leader>r",
  string.format(":w | :TermExec cmd='ghci %s && :q' size=25 direction=float go_back=0<CR>", file),
  { desc = "Run Haskell (ghci)" }
)
map("n", "<leader>R", ":w | :TermExec cmd='cabal run' size=25 direction=float go_back=0<CR>", { desc = "cabal run" })
