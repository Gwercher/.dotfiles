local Util = require("lazyvim.util")
local map = Util.safe_keymap_set

-- information: https://azeria-labs.com/arm-on-x86-qemu-user/

map(
  "n",
  "<leader>r",
  ":w | :TermExec cmd='arm-linux-gnueabihf-as -g %:p -o %:p:r.o && arm-linux-gnueabihf-ld -static %:p:r.o -o %:p:r && %:p:r' size=25 direction=float go_back=0<CR>",
  { desc = "ARM 32-Bit" }
)
map(
  "n",
  "<leader>R",
  ':w | :TermExec cmd=\'arm-linux-gnueabihf-as -g %:p -o %:p:r.o && arm-linux-gnueabihf-ld -static %:p:r.o -o %:p:r && qemu-arm -L /usr/arm-linux-gnueabihf -g 1234 %:p:r & gdb-multiarch -q --nh -ex "set architecture arm" -ex "file %:p:r" -ex "target remote localhost:1234" -ex "layout split" -ex "layout regs" && :q \' size=80 direction=vertical go_back=0<CR>',
  { desc = "ARM 32-Bit GBU" }
)
