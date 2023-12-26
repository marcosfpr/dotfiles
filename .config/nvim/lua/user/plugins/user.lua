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
  { "folke/trouble.nvim", enabled = false },

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
  }}
