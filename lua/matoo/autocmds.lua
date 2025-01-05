local ftgroup = vim.api.nvim_create_augroup("ft", { clear = true })

-- enable wrapping for certain file types
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = { "*.typ", "*.md", "*.txt" },
	command = "setlocal wrap",
	group = ftgroup,
})

-- automatically open typst preview
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*.typ",
	command = "TypstPreview",
	command = "",
	group = ftgroup,
})
