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
require('telescope').setup{
    defaults = {
        file_ignore_patterns = {
            "node_modules",
	    "vendor",
        }
    }
}
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
map('n', '<Leader>[', ':BufferPrevious<CR>', options)
map('n', '<Leader>]', ':BufferNext<CR>', options)

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

-- lsp + lsp mappings
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local servers = { 'rust_analyzer', 'gopls', 'solargraph' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup { on_attach = on_attach }
end

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
    autocmd BufWritePre * Neoformat
augroup END
let g:neoformat_enabled_go = ['gofumpt', 'goimports', 'gofmt']
]]
vim.g.go_fmt_autosave = 0
