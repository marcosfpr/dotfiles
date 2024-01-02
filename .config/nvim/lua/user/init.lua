return {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },
  -- Set colorscheme to use
  -- colorscheme = "astrodark",
  -- colorscheme = "tokyonight",
  colorscheme = "catppuccin",
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    on_attach = function(client, bufnr)
      local ih = require "lsp-inlayhints"
      ih.setup()
      ih.on_attach(client, bufnr)
    end,
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000,
    },
    setup_handlers = {
      rust_analyzer = function(_, _)
        require("rust-tools").setup {
          tools = { -- rust-tools options

            -- how to execute terminal commands
            -- options right now: termopen / quickfix / toggleterm / vimux
            executor = require("rust-tools.executors").toggleterm,

            -- callback to execute once rust-analyzer is done initializing the workspace
            -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
            on_initialized = nil,

            -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
            reload_workspace_from_cargo_toml = true,

            -- These apply to the default RustSetInlayHints command
            inlay_hints = {
              -- automatically set inlay hints (type hints)
              -- default: true
              auto = true,

              -- Only show inlay hints for the current line
              only_current_line = false,

              -- whether to show parameter hints with the inlay hints or not
              -- default: true
              show_parameter_hints = true,

              -- prefix for parameter hints
              -- default: "<-"
              parameter_hints_prefix = "<- ",

              -- prefix for all the other hints (type, chaining)
              -- default: "=>"
              other_hints_prefix = "=> ",

              -- whether to align to the length of the longest line in the file
              max_len_align = false,

              -- padding from the left if max_len_align is true
              max_len_align_padding = 1,

              -- whether to align to the extreme right or not
              right_align = false,

              -- padding from the right if right_align is true
              right_align_padding = 7,

              -- The color of the hints
              highlight = "Comment",
            },

            -- options same as lsp hover / vim.lsp.util.open_floating_preview()
            hover_actions = {

              -- the border that is used for the hover window
              -- see vim.api.nvim_open_win()
              border = {
                { "╭", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╮", "FloatBorder" },
                { "│", "FloatBorder" },
                { "╯", "FloatBorder" },
                { "─", "FloatBorder" },
                { "╰", "FloatBorder" },
                { "│", "FloatBorder" },
              },

              -- Maximal width of the hover window. Nil means no max.
              max_width = nil,

              -- Maximal height of the hover window. Nil means no max.
              max_height = nil,

              -- whether the hover action window gets automatically focused
              -- default: false
              auto_focus = true,
            },

          },

          server = {
            -- standalone file support
            -- setting it to false may improve startup time
            standalone = true,
            on_attach = function(_, bufnr)
              -- Hover actions
              vim.keymap.set("n", "<Leader>ha", require("rust-tools").hover_actions.hover_actions,
                { buffer = bufnr, desc = "hover actions" })
              -- Code action groups
              vim.keymap.set("n", "<Leader>ca", require("rust-tools").code_action_group.code_action_group,
                { buffer = bufnr, desc = "code actions" })
            end,
            settings = {
              ['rust-analyzer'] = {
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
                    'cargo', 'clippy', '--message-format=json', '--all-features',
                    '--all-targets', '--', '-W', 'clippy::pedantic', '-W', 'clippy::nursery',
                    '-W', 'clippy::unwrap_used', '-W', 'clippy::expect_used', '-W', 'clippy::all',
                    '-W', 'clippy::style', '-W', 'clippy::must_use_candidate', '-W', 'clippy::missing_const_for_fn'
                  }
                }
              }
            }
          },
        }
      end,
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "python"
    },
  },
  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}
