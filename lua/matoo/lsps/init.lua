function GetCapabilities(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()
	cmpCapabilities = vim.tbl_deep_extend("force", capabilities, cmpCapabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}
	return capabilities
end

require("lze").load({
	"nvim-lspconfig",
	event = "FileType",
	after = function()
		-- todo: general lsp config goes here
		vim.diagnostic.config({
			update_in_insert = true,
		})
		local servers = require("matoo.lsps.servers")
		for server, config in pairs(servers) do
			require("lspconfig")[server].setup({
				settings = config,
				capabilities = GetCapabilities(server),
				filetypes = (config or {}).filetypes,
				cmd = (config or {}).cmd,
				root_pattern = (config or {}).root_pattern,
			})
			-- vim.api.nvim_exec_autocmds("FileType", {})
		end
		-- todo: define keybinds for lsp operations, ie rename
		-- defaults:
		-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
		-- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
		-- vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
		-- vim.keymap.set("n", "gi", vim.lsp.buf.implementations, { desc = "[G]oto [I]mplementations" })
		-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
		-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
		-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
	end,
})
