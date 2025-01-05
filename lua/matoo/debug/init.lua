require("lze").load({
	{
		"nvim-dap",
		dep_of = "nvim-jdtls",
		keys = {
			{ "<f5>", desc = "Debug: Start/Continue" },
			{ "<s-f5>", desc = "Debug: Stop" },
			{ "<c-s-f5>", desc = "Debug: Restart" },
			{ "<f10>", desc = "Debug: Step over" },
			{ "<f11>", desc = "Debug: Step into" },
			{ "<s-f11>", desc = "Debug: Step out" },
			{ "<f7>", desc = "Debug: See last session result" },
			{ "<leader>b", desc = "Debug: Toggle breakpoint" },
			-- { "<leader>B", desc = "Debug: Set breakpoint" },
		},
		load = function(name)
			vim.cmd.packadd(name)
			vim.cmd.packadd("nvim-nio")
			vim.cmd.packadd("nvim-dap-ui")
			vim.cmd.packadd("nvim-dap-virtual-text")
		end,
		after = function()
			local dap = require("dap")
			local ui = require("dapui")
			require("nio")
			local virt = require("nvim-dap-virtual-text")

			vim.keymap.set("n", "<f5>", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<c-f5>", dap.close, { desc = "Debug: Stop" })
			vim.keymap.set("n", "<c-s-f5>", dap.restart, { desc = "Debug: Restart" })
			vim.keymap.set("n", "<f10>", dap.step_over, { desc = "Debug: Step over" })
			vim.keymap.set("n", "<f11>", dap.step_into, { desc = "Debug: Step into" })
			vim.keymap.set("n", "<s-f11>", dap.step_out, { desc = "Debug: Step out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle breakpoint" })
			-- vim.keymap.set(
			-- 	"n",
			-- 	"<leader>B",
			-- 	dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")),
			-- 	{ desc = "Debug: Set breakpoint" }
			-- )

			vim.keymap.set("n", "<f7>", ui.toggle, { desc = "Debug: See last session result" })
			dap.listeners.after.event_initialized["dapui_config"] = ui.open
			dap.listeners.before.event_terminated["dapui_config"] = ui.close
			dap.listeners.before.event_exited["dapui_config"] = ui.close

			ui.setup()
			virt.setup({
				enabled = true,
				enabled_commands = true,
				highlight_changed_variables = true,
				highlight_new_as_changed = true,
				shop_stop_reason = true,
				commented = false,
				only_first_definition = true,
				all_references = false,
				clear_on_continue = false,

				display_callback = function(variable, buf, stackframe, node, options)
					if options.virt_text_pos == "inline" then
						return " = " .. variable.value:gsub("%s+", " ")
					else
						return variable.name .. " = " .. variable.value
					end
				end,

				virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
			})

			require("matoo.debug.debuggers")
		end,
	},
})
