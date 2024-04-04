require 'plugins'

-- variables for keybindings
local map = vim.api.nvim_set_keymap
options   = { noremap = true }

-- leader
vim.g.mapleader = ' '

-- window navigation
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)

-- save
map('n', '<Leader>s', ':w<CR>', options)

-- hide highlight
map('n', '<Leader>h', ':noh<CR>', options)

-- listchars
vim.o.list      = true
vim.o.listchars = "tab:‣ ,trail:·,nbsp:·,precedes:←,extends:→"
vim.cmd([[match errorMsg /\s\+$/]])

-- line numbers
vim.o.number         = true
vim.o.relativenumber = true

-- colorcolumn
vim.o.cc = '80,120'

-- colorscheme
vim.o.termguicolors = true
vim.o.background    = 'dark'
vim.cmd([[colorscheme gruvbox]])

-- transparency
require('transparent').setup({ enable = true })

-- file finder
map('n', '<Leader>ff', '<CMD>Telescope find_files<CR>', options)
map('n', '<Leader>fb', '<CMD>Telescope buffers<CR>', options)
map('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>', options)

-- markdown rendering
map('n', '<Leader>m', '<CMD>Glow<CR>', options)

-- terminal
require'FTerm'.setup({
    border = 'none',
})
map('n', '<Leader>t', '<CMD>lua require("FTerm").toggle()<CR>', options)
map('t', '<Leader>t', '<CMD>lua require("FTerm").toggle()<CR>', options)

-- spellcheck
vim.o.spelllang = 'en'
map('n', '<Leader>sp', '<CMD>set spell!<CR>', options)

-- bar navigation
map('n', '<C-p>', ':BufferPrevious<CR>', options)
map('n', '<C-n>', ':BufferNext<CR>', options)

-- bar close
map('n', '<Leader>w', ':BufferClose<CR>', options)

-- status line
require('lualine').setup {
    options = { theme = 'gruvbox' },
}

-- git blame
vim.g.gitblame_enabled = 0
map('n', '<Leader>gb', ':GitBlameToggle<CR>', options)

-- git signs
require('gitsigns').setup()

-- comments
require('Comment').setup()

-- lsp
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.solargraph.setup{}

-- auto complete
vim.g.coq_settings = { auto_start = 'shut-up' }
require('coq')

-- auto pairs
local npairs = require('nvim-autopairs')
npairs.setup({ map_bs = false, map_cr = false })
vim.g.coq_settings = { keymap = { recommended = false } }
auto_pair_options = { expr = true, noremap = true }

map('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], auto_pair_options)
map('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], auto_pair_options)
map('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], auto_pair_options)
map('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], auto_pair_options)

_G.MUtils= {}

MUtils.CR = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
            return npairs.esc('<c-y>')
        else
            return npairs.esc('<c-e>') .. npairs.autopairs_cr()
        end
    else
        return npairs.autopairs_cr()
    end
end
map('i', '<cr>', 'v:lua.MUtils.CR()', auto_pair_options)

MUtils.BS = function()
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
        return npairs.autopairs_bs()
    end
end
map('i', '<bs>', 'v:lua.MUtils.BS()', auto_pair_options)

-- formatting
vim.cmd[[
augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
augroup END
let g:neoformat_enabled_go = ['gofumpt', 'goimports', 'gofmt']
]]
vim.g.go_fmt_autosave = 0
