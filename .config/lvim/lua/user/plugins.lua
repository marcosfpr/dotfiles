lvim.plugins = {
	{ "lunarvim/colorschemes" },
	{ "rebelot/kanagawa.nvim" },
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
}
