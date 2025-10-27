local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map(
  "n",
  "<leader>r",
  ":w | :TermExec cmd='ghci %:p && :q' size=25 direction=float go_back=0<CR>",
  { desc = "Run Haskell (ghci)" }
)
map("n", "<leader>R", ":w | :TermExec cmd='cabal run' size=25 direction=float go_back=0<CR>", { desc = "cabal run" })
