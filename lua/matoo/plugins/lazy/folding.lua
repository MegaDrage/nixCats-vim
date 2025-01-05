return {
	{
		"nvim-ufo",
		after = function()
			require("ufo").setup {
			}
		end,
	},
	{
		"indent-blankline.nvim",
		after = function ()
			require("ibl").setup {
			}
		end
	},
}
