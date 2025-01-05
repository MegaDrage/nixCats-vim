return {
	"hardtime.nvim",
	after = function ()
		require("hardtime").setup {
			enabled = true,
			disable_mouse = true,
		}
	end
}
