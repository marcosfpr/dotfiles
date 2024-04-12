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
					suggestion = {
						enabled = true,
						keymap = {
							accept = "<Right>",
							next = "<Up>",
							prev = "<Down>",
							dismiss = "<Left>",
						},
					},
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
}
