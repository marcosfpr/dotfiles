return {

  {
    "ThePrimeagen/vim-be-good",
    event = "VeryLazy",
    -- cmd = {
    --   "VimBeGood",
    -- },
  },
  {
    "fladson/vim-kitty",
    ft = "kitty.conf",
    event = "VeryLazy",
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
  },
  {
    "roobert/surround-ui.nvim",
    event = "VeryLazy",
    dependencies = {
      "kylechui/nvim-surround",
      "folke/which-key.nvim",
    },
    config = function()
      require("surround-ui").setup {
        root_key = "S",
      }
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    opts = {
      -- options
    },
  },
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim",       enabled = false },

  -- transparent
  {
    "xiyaowong/transparent.nvim",
    cmd = {
      "TransparentEnable",
      "TransparentDisable",
      "TransparentToggle",
    },
  },

  {
    "mg979/vim-visual-multi",
    event = "VeryLazy"
  },
  {
    "zbirenbaum/copilot.lua",
    event = "VimEnter",
    config = function()
      vim.defer_fn(function()
        require("copilot").setup()
      end, 100)
    end,
  },

  -- lsp additional packages
  { "neovim/nvim-lspconfig" },
  { 'simrat39/inlay-hints.nvim' },
  {
    "lvimuser/lsp-inlayhints.nvim",
    branch = "main", -- or "anticonceal"
    -- lazy = false,
    after = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("inlay-hints")
    end,
  },
  {
    'saecki/crates.nvim',
    ft = { "toml" },
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = { { name = "crates" } }
      })
      crates.show()
      -- require("core.utils").load_mappings("crates")
    end,
  },
  {
    "simrat39/rust-tools.nvim",
    after = "nvim-lspconfig",
    ft = { "rust", "rs" },
  },


}
