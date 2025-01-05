return {
	"treesj",
	keys = {
		{ "<leader>m", desc = "Split or Join code block with autodetect" },
		{ "<leader>j", desc = "Join code block" },
		{ "<leader>s", desc = "Split code block" },
	},
	after = function()
		require("treesj").setup({})
	end,
}
