vim.keymap.set("n", "<leader>ut", function()
	vim.cmd.UndotreeToggle()
	vim.cmd.UndotreeFocus()
end, { desc = "[U]ndotree [T]oggle" })

return {
	"undotree",
	cmd = "UndotreeToggle",
}
