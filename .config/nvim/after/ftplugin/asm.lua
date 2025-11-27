local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

map(
  "n",
  "<leader>r",
  ":w | :TermExec cmd='arm-linux-gnueabihf-as %:p -o %:p:r.o && arm-linux-gnueabihf-ld -static %:p:r.o -o %:p:r && %:p:r' size=25 direction=float go_back=0<CR>",
  { desc = "ARM 32-Bit" }
)
