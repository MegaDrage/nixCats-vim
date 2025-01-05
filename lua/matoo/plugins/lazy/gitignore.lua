return {
	"gitignore.nvim",
	cmd = "Gitignore",
	keys = {
		{ "<leader>gi", desc = "Generate [G]it[I]gnore" },
	},
	after = function()
		require("gitignore")
		vim.keymap.set("n", "<leader>gi", require("gitignore").generate, { desc = "Generate [G]it[I]gnore" })
	end,
}
