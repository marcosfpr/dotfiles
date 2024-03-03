-- vim.keymap.set("n", "<leader>a", require("lspimport").import, { noremap = true })
require("which-key").register({
	E = {
		name = "Environment+",
		a = { "<cmd>lua require('swenv.api').auto_venv()<cr>", "[A]uto Set Python Virtualenv" },
		s = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "[S]et Python Virtualenv" },
		g = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", "[G]et Python Virtualenv" },
	},
})
