local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{
		name = "black",
		extra_args = { "--line-length", "79", "--enable-unstable-feature=string_processing", "--preview" },
	},
	{ name = "isort" },
	{
		name = "prettier",
	},
	{ name = "stylua" },
	{ name = "rustfmt" },
	{ name = "shfmt" },
})

-- local linters = require("lvim.lsp.null-ls.linters")
-- linters.setup({
-- 	{ name = "flake8" },
-- })

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{
		name = "proselint",
	},
})
