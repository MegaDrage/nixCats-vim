return {
	"comment.nvim",
	event = "BufEnter",
	keys = { "gc", "gcc", "gbc" },
	after = function()
		require("Comment").setup({
			sticky = false,
		})
	end,
}
