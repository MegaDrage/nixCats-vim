return {
	{
		"typst-preview.nvim",
		cmd = "TypstPreview",
		ft = "typst",
		after = function()
			require("typst-preview").setup({
				debug = false,
				invert_colors = "auto",
			})
			-- auto-start preview when editing a typst file
			-- this only works the first time the plugin is loaded
			-- todo: find a way to do this automatically
			-- vim.cmd([[TypstPreview]])
		end,
	},
	{
		"typst-conceal.vim",
		ft = "typst",
		after = function()
			-- only works if treesitter is disabled, so it does nothing for now:
			-- https://github.com/MrPicklePinosaur/typst-conceal.vim/issues/1
			vim.opt.conceallevel = 2
			vim.g.typst_conceal_math = 1
			vim.g.typst_conceal_emoji = 1
		end,
	},
}
