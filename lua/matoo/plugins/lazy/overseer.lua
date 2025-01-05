return {
	{
		"dressing.nvim",
		dep_of = "overseer.nvim",
	},
	{
		"overseer.nvim",
		keys = {
			{ "<leader>or", desc = "[O]verseer [R]un" },
			{ "<leader>ot", desc = "[O]verseer [T]oggle" },
		},
		after = function()
			require("overseer").setup({
				dap = false,
				templates = {
					"builtin",
					"user.c_compile",
					"user.c_compile_run",
					"user.c_debug",
					"user.cpp_compile",
					"user.cpp_compile_run",
					"user.cpp_debug",
				},
			})
			vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "[O]verseer [R]un" })
			vim.keymap.set("n", "<leader>ot", function()
				require("overseer").toggle({ direction = "left" })
			end, { desc = "[O]verseer [T]oggle" })
		end,
	},
}
