lvim.plugins = {
	{ "lunarvim/colorschemes" },
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("kanagawa").setup({
				compile = false, -- enable compiling the colorscheme
				undercurl = true, -- enable undercurls
				commentStyle = { italic = false },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = false, -- do not set background color
				dimInactive = false, -- dim inactive window `:h hl-NormalNC`
				terminalColors = true, -- define vim.g.terminal_color_{0,17}
				colors = { -- add/modify theme and palette colors
					palette = {},
					theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
				},
				overrides = function(colors) -- add/modify highlights
					return {}
				end,
				theme = "dragon", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "dragon", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
	},
	-- Useful status updates for LSP
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({ window = { winblend = 0 } })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					panel = {
						enabled = true,
						auto_refresh = false,
						keymap = {
							jump_prev = "[[",
							jump_next = "]]",
							accept = "<CR>",
							refresh = "gr",
							open = "<M-CR>",
						},
						layout = {
							position = "bottom", -- | top | left | right
							ratio = 0.4,
						},
					},
					suggestion = {
						enabled = true,
						auto_trigger = true,
						debounce = 75,
						keymap = {
							accept = "<Right>",
							next = "<Up>",
							prev = "<Down>",
							dismiss = "<Left>",
						},
					},
					filetypes = {
						yaml = false,
						markdown = false,
						help = false,
						gitcommit = false,
						gitrebase = false,
						hgcommit = false,
						svn = false,
						cvs = false,
						["."] = false,
					},
					copilot_node_command = "node", -- Node.js version must be > 18.x
					server_opts_overrides = {},
				})
			end, 100)
		end,
	},
	{ "simrat39/rust-tools.nvim" },
	{
		"saecki/crates.nvim",
		version = "v0.3.0",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
				popup = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"AckslD/swenv.nvim",
		config = function()
			require("swenv").setup({
				post_set_venv = function()
					vim.cmd("LspRestart")
				end,
			})
		end,
	},
	{ "stevearc/dressing.nvim" },
	{ "stevanmilic/nvim-lspimport" },
	{ "nvim-pack/nvim-spectre" },
	{
		"lervag/vimtex",
		init = function()
			-- Use init for configuration, don't use the more common "config".
		end,
	},
	{ "p00f/alabaster.nvim" },
	{ "shaunsingh/nord.nvim" },
	{ -- This plugin
		"Zeioth/makeit.nvim",
		cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
		dependencies = { "stevearc/overseer.nvim" },
		opts = {},
	},
	{ -- The task runner we use
		"stevearc/overseer.nvim",
		commit = "400e762648b70397d0d315e5acaf0ff3597f2d8b",
		cmd = { "MakeitOpen", "MakeitToggleResults", "MakeitRedo" },
		opts = {
			task_list = {
				direction = "bottom",
				min_height = 25,
				max_height = 25,
				default_detail = 1,
			},
		},
	},
	{
		"ellisonleao/gruvbox.nvim",

		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = false,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = true,
				},
				strikethrough = false,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
		end,
	},
}
