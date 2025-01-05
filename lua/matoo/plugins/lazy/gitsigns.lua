return {
	"gitsigns.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("gitsigns").setup {
			signs = {
				add = { text = "+┃" },
				change = { text = "~┃" },
				delete = { text = "-┃" },
				topdelete = { text = "-┃" },
				changedelete = { text = "~┃" },
				untracked = { text = "?┃" },
			},
			signs_staged = {
				add = { text = "+┃" },
				change = { text = "~┃" },
				delete = { text = "-┃" },
				topdelete = { text = "-┃" },
				changedelete = { text = "~┃" },
				untracked = { text = "?┃" },
			},
			signs_staged_enable = true,

		}
		vim.cmd([[hi GitSignsAdd guifg=#9ecd6f]])
		vim.cmd([[hi GitSignsAdd guifg=#9ecd6f]])
		vim.cmd([[hi GitSignsChange guifg=#78dce8]])
		vim.cmd([[hi GitSignsDelete guifg=#dc5577]])
		vim.cmd([[hi GitSignsStagedAdd guifg=#9ecd6f]])
		vim.cmd([[hi GitSignsStagedChange guifg=#78dce8]])
		vim.cmd([[hi GitSignsStagedDelete guifg=#dc5577]])
	end,
}
