local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

local file = vim.fn.expand("%:p")
local outfile = vim.fn.expand("%:p:r")

map(
  "n",
  "<leader>r",
  string.format(":w | :TermExec cmd='pdflatex %s; :q' size=25 direction=float go_back=0<CR>", file),
  { desc = "Build and Run Tex File" }
)
