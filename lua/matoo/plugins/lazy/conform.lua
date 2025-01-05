return {
	"conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	after = function()
		require("conform").setup({
			notify_on_error = true,
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				c = { "astyle" },
				cpp = { "astyle" },
				cs = { "csharpier" },
				gdscript = { "gdformat" },
				java = { "astyle" },
				nix = { "nixfmt" },
				rust = { "rustfmt" },
				tex = { "tex-fmt" },
				typst = { "typstyle" },
			},
			formatters = {
				astyle = {
					inherit = true,
					args = {
						"-t4",
					},
				},
				nixfmt = {
					inherit = true,
					--customization of tab width is not yet supported
				},
			},
		})
	end,
}
