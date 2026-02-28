local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map(
  "n",
  "<leader>r",
  ":w | :TermExec cmd='g++ %:p -o %:p:r -g -Wall -Wextra -Werror -Wpedantic --std=c++20 -Wno-unused-but-set-variable -Wno-unused-variable -Wno-unused-parameter && %:p:r' size=65 direction=vertical go_back=1<CR>",
  { desc = "Build and Run C++ File (debug)" }
)

map(
  "n",
  "<leader>R",
  ":w | :TermExec cmd='g++ %:p -o %:p:r -O2 -Wall -Wextra -Werror -Wpedantic --std=c++20 -Wsign-conversion && %:p:r' size=65 direction=vertical go_back=1<CR>",
  { desc = "Build and Run C++ File (strict)" }
)

map("n", "<leader>m", ":w | :TermExec cmd='make run' size=65 direction=vertical go_back=1<CR>", { desc = "Make run" })
