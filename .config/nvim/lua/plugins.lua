vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- package management
    use 'wbthomason/packer.nvim'

    -- colorscheme
    use 'ellisonleao/gruvbox.nvim'

    -- transparency
    use 'xiyaowong/nvim-transparent'

    -- icons
    use 'kyazdani42/nvim-web-devicons'

    -- dependency for many packages
    use 'nvim-lua/plenary.nvim'

    -- file finder
    use 'nvim-telescope/telescope.nvim'

    -- markdown rendering
    use 'ellisonleao/glow.nvim'

    -- terminal
    use 'numToStr/FTerm.nvim'

    -- bar...bar
    use 'romgrk/barbar.nvim'

    -- status line
    use 'nvim-lualine/lualine.nvim'

    -- highlight same words
    use 'RRethy/vim-illuminate'

    -- git blame
    use 'f-person/git-blame.nvim'

    -- git signs
    use 'lewis6991/gitsigns.nvim'

    -- comments
    use 'numToStr/Comment.nvim'

    -- auto pairs
    use 'windwp/nvim-autopairs'

    -- lsp
    use 'neovim/nvim-lspconfig'

    -- auto complete
    use { 'ms-jpq/coq_nvim', branch = 'coq' }

    -- snippets
    use { 'ms-jpq/coq.artifacts', branch = 'artifacts' }

    -- rust
    use 'rust-lang/rust.vim'

    -- go
    use 'fatih/vim-go'

    -- rails
    use 'tpope/vim-rails'

    -- formatting
    use 'sbdchd/neoformat'
end)
