return {
	"trouble.nvim",
	cmd = "Trouble",
	keys = {
		{ "<leader>tr", desc = "[TR]ouble diagnostics toggle" },
	},
	after = function()
		require("trouble").setup({
			warn_no_results = false,
			open_no_results = true,
			focus = true,
		})
		vim.keymap.set(
			"n",
			"<leader>tr",
			"<cmd>Trouble diagnostics toggle<cr>",
			{ desc = "[TR]ouble diagnostics toggle" }
		)
	end,
}
