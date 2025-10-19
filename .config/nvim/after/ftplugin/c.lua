local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

local file = vim.fn.expand("%:p")
local outfile = vim.fn.expand("%:p:r")

map(
  "n",
  "<leader>r",
  string.format(
    ":w | :TermExec cmd='gcc %s -o %s -Wall -Wextra -Werror -Wpedantic -std=c18 && %s' size=50 direction=float go_back=0<CR>",
    file,
    outfile,
    outfile
  ),
  { desc = "Build and Run C File" }
)
