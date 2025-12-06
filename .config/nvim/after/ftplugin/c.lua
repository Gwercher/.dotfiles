local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map(
  "n",
  "<leader>r",
  ":w | :TermExec cmd='gcc %:p -o %:p:r -g -Wall -Wextra -Werror -Wpedantic -std=c18 -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-parameter && %:p:r' size=25 direction=float go_back=0<CR>",
  { desc = "Build and Run C File (debug)" }
)

map(
  "n",
  "<leader>R",
  ":w | :TermExec cmd='gcc %:p -o %:p:r -Wall -Wextra -Werror -Wpedantic -std=c18 && %:p:r' size=25 direction=float go_back=0<CR>",
  { desc = "Build and Run C File (strict)" }
)
