return function(use)
    use {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            vim.defer_fn(function()
                require("copilot").setup()
            end, 100)
        end,
    }

    --- use 'neovim/nvim-lspconfig'
    use 'simrat39/rust-tools.nvim'

    -- Debugging
    --- use 'nvim-lua/plenary.nvim'
    use 'mfussenegger/nvim-dap'


    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }


    use {
        "windwp/nvim-autopairs", -- Autocomplete (), {}, []
        config = function() require("nvim-autopairs").setup {} end
    }

    use 'onsails/lspkind.nvim'         -- shows icons in cmp
    use 'lukas-reineke/headlines.nvim' -- highlights headlines for markdown, other txt files

    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp'  -- LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'     -- Snippet completion source for nvim-cmp
    use 'hrsh7th/cmp-path'      -- Useful completion sources
    use 'hrsh7th/cmp-buffer'    -- Useful completion sources
    use 'hrsh7th/vim-vsnip'     -- Snippet engine
    use 'nvim-lua/popup.nvim'   -- Poup for telescope
    use 'm-demare/hlargs.nvim'  -- Highlight argument definitions and usages
    use 'nvim-lua/plenary.nvim' -- Collection of Lua functions
end
