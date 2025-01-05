return {
	"obsidian.nvim",
	ft = "markdown",
	keys = {
		{ "gF", desc = "Obsidian Backlinks" },
	},
	after = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "Uni",
					-- this is symlinked to avoid doxxing myself with where I study
					path = "~/Obsidian/vaults/uni",
				},
			},
			completion = {
				nvim_cmp = true,
			},
			new_notes_location = "current_dir",
			picker = {
				name = "telescope.nvim",
			},
			sort_by = "modified",
			sort_reversed = "true",
			open_notes_in = "current",
			attachments = {
				img_foldr = "current_dir",
			},
			disable_frontmatter = true,
		})
		vim.keymap.set("n", "gF", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Backlinks" })
	end,
}
