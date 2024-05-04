vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")
local codelldb_adapter = {
	type = "server",
	port = "${port}",
	executable = {
		command = mason_path .. "bin/codelldb",
		args = { "--port", "${port}" },
	},
}

pcall(function()
	require("rust-tools").setup({
		tools = {
			executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
			reload_workspace_from_cargo_toml = true,
			runnables = {
				use_telescope = true,
			},
			hover_actions = {
				border = "rounded",
			},
			on_initialized = function()
				vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
					pattern = { "*.rs" },
					callback = function()
						local _, _ = pcall(vim.lsp.codelens.refresh)
					end,
				})
			end,
		},
		dap = {
			adapter = codelldb_adapter,
		},
		server = {
			on_attach = function(client, bufnr)
				require("lvim.lsp").common_on_attach(client, bufnr)
				local rt = require("rust-tools")
				vim.keymap.set("n", "K", rt.hover_actions.hover_actions, { buffer = bufnr })
			end,

			capabilities = require("lvim.lsp").common_capabilities(),
			settings = {
				["rust-analyzer"] = {
					lens = {
						enable = true,
					},
					checkOnSave = {
						enable = true,
						command = "clippy",
					},
					-- checkOnSave = {
					--    allFeatures = true,
					--    overrideCommand = {
					--      "cargo",
					--      "clippy",
					--      "--message-format=json",
					--      "--all-features",
					--      "--all-targets",
					--      "--",
					--      "-W",
					--      "clippy::pedantic",
					--      "-W",
					--      "clippy::nursery",
					--      "-W",
					--      "clippy::unwrap_used",
					--      "-W",
					--      "clippy::expect_used",
					--      "-W",
					--      "clippy::all",
					--      "-W",
					--      "clippy::style",
					--      "-W",
					--      "clippy::must_use_candidate",
					--      "-W",
					--      "clippy::missing_const_for_fn",
					--    },
					--  },
				},
			},
		},
	})
end)
