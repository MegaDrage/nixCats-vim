require("matoo.plugins.colorscheme")
require("nvim-web-devicons").setup()
require("matoo.plugins.oil")

require("lze").load({
	{ import = "matoo.plugins.lazy.autopairs" },
	{ import = "matoo.plugins.lazy.comment" },
	{ import = "matoo.plugins.lazy.completion" },
	{ import = "matoo.plugins.lazy.conform" },
	{ import = "matoo.plugins.lazy.flash" },
	{ import = "matoo.plugins.lazy.folding" },
	{ import = "matoo.plugins.lazy.gitignore" },
	{ import = "matoo.plugins.lazy.gitsigns" },
	{ import = "matoo.plugins.lazy.hardtime" },
	{ import = "matoo.plugins.lazy.image" },
	{ import = "matoo.plugins.lazy.lualine" },
	{ import = "matoo.plugins.lazy.markview" },
	{ import = "matoo.plugins.lazy.move" },
	{ import = "matoo.plugins.lazy.obsidian" },
	{ import = "matoo.plugins.lazy.overseer" },
	{ import = "matoo.plugins.lazy.surround" },
	{ import = "matoo.plugins.lazy.telescope" },
	{ import = "matoo.plugins.lazy.tmux-navigator" },
	{ import = "matoo.plugins.lazy.treesitter" },
	{ import = "matoo.plugins.lazy.treesj" },
	{ import = "matoo.plugins.lazy.trouble" },
	{ import = "matoo.plugins.lazy.typst" },
	{ import = "matoo.plugins.lazy.undotree" },
	{ import = "matoo.plugins.lazy.whichkey" },
})
