return {
	"lualine.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "|", right = "|" },
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diagnostics" },
				lualine_c = { "buffers" },
				lualine_x = { "filetype" },
				lualine_y = { "branch" },
				lualine_z = { "location" },
			},
		})
	end,
}
