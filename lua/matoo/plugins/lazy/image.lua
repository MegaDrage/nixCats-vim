return {
	"image.nvim",
	ft = { "typst", "markdown" },
	after = function()
		require("image").setup({
			backend = "kitty",
			processor = "magick_rock",
			integrations = {
				typst = {
					enabled = true,
					filetypes = { "typst" },
				},
				markdown = {
					enabled = true,
					filetypes = { "markdown" },
				},
			},
			hijack_file_patterns = {
				"*.svg",
				"*.png",
				"*.jpg",
				"*.jpeg",
				"*.gif",
				"*.webp",
				"*.avif",
			},
		})
	end,
}
