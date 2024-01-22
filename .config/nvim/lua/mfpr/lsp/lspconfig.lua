local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

-- Enable border for LspInfo
require("lspconfig.ui.windows").default_options.border = "rounded"

vim.diagnostic.config({
	-- Limit length
	open_float = {
		width = 80,
	},
	-- Enable border
	float = {
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
})

local on_attach = require("mfpr.lsp.handlers").on_attach
local capabilities = require("mfpr.lsp.handlers").capabilities

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {

		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.pyright.setup({

	on_attach = on_attach,
	capabilities = capabilities,

	settings = {

		python = {
			analysis = {
				typeCheckingMode = "true",
			},
		},
	},
})

-- Rust does not require manual initialization of lspconfig as rust-tools
-- does that for us.
local rt = require("rust-tools")

rt.setup({
	tools = {
		executor = require("rust-tools.executors").toggleterm,
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
	},

	server = {
		standalone = true,
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)

			-- Hover actions
			vim.keymap.set(
				"n",
				"<Leader>ha",
				rt.hover_actions.hover_actions,
				{ buffer = bufnr, desc = "hover actions" }
			)
			-- Code action groups
			vim.keymap.set(
				"n",
				"<Leader>ca",
				rt.code_action_group.code_action_group,
				{ buffer = bufnr, desc = "code actions" }
			)
		end,
		capabilities = capabilities,
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
	},
})
