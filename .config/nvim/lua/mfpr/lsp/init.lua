local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("mfpr.lsp.lspconfig")
require("mfpr.lsp.handlers").setup()
require("mfpr.lsp.null-ls")
