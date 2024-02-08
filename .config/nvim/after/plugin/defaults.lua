local rt = require("rust-tools")

local opts = {

  tools = {
    executor = require("rust-tools.executors").termopen,
    on_initialized = nil,
    reload_workspace_from_cargo_toml = true,
    inlay_hints = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
    hover_actions = {
      auto_focus = true,
    }
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
    on_attach = function(client, bufnr)
      require("mfpr.lsp-settings").on_attach(client, bufnr)
      -- Hover actions
      vim.keymap.set(
        "n",
        "<leader>a",
        rt.hover_actions.hover_actions,
        { buffer = bufnr, desc = "[R]ust [H]over" }
      )
      -- Code action groups
      vim.keymap.set(
        "n",
        "<leader>r",
        rt.code_action_group.code_action_group,
        { buffer = bufnr, desc = "[R]ust [A]ctions" }
      )
    end,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
        procMacro = {
          attributes = {
            enable = true,
          },
        },
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--message-format=json",
            "--all-features",
            "--all-targets",
            "--",
            "-W",
            "clippy::pedantic",
            "-W",
            "clippy::nursery",
            "-W",
            "clippy::unwrap_used",
            "-W",
            "clippy::expect_used",
            "-W",
            "clippy::all",
            "-W",
            "clippy::style",
            "-W",
            "clippy::must_use_candidate",
            "-W",
            "clippy::missing_const_for_fn",
          },
        },
      },
    },
  }, -- rust-analyzer options

  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb-vscode",
      name = "rt_lldb",
    },
  },
}

require('rust-tools').setup(opts)

require('rust-tools').inlay_hints.set()
require('rust-tools').inlay_hints.enable()
