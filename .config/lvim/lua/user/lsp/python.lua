require("swenv").setup({
	get_venvs = function(venvs_path)
		return require("swenv.api").get_venvs(venvs_path)
	end,
	-- Path passed to `get_venvs`.
	venvs_path = vim.fn.expand("~/venvs"),
	post_set_venv = function()
		vim.cmd("LspRestart")
	end,
})
