return {
	"markview.nvim",
	ft = "markdown",
	after = function()
		require("markview").setup({
			callbacks = {
				on_enable = {
					conceallevel = 2,
					concealcursor = "",
				},
				on_disable = {
					conceallevel = 0,
					concealcursor = "",
				},
			},
		})
	end,
}
