-- listchars
vim.o.list = true
vim.o.listchars = "tab:‣ ,trail:·,nbsp:·,precedes:←,extends:→"

-- line numbers
vim.o.relativenumber = true

-- colorcolumn
vim.o.cc = "80"

-- indenting
vim.cmd [[
  set tabstop=8
  autocmd Filetype go setlocal noexpandtab shiftwidth=8
]]

