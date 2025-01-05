require("monokai-pro").setup {
	-- doesnt work on gnome without a big workaround, so its a placeholder for now
	transparent_background = false,
	devicons = true,
	filter = "pro",
}

vim.cmd([[colorscheme monokai-pro]])
