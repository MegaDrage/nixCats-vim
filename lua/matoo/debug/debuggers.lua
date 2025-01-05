local dap = require("dap")

------------------------
---- C / C++ / Rust ----
------------------------

dap.adapters.gdb = {
	name = "gdb",
	type = "executable",
	command = vim.fn.exepath("gdb"),
	args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
}

dap.adapters.lldb = {
	name = "lldb",
	type = "executable",
	command = vim.fn.exepath("lldb-dap"),
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.cpp = {
	{
		name = "GDB Debug",
		type = "gdb",
		request = "launch",
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = true,
		program = function()
			return vim.fn.input("Path to executable:", vim.fn.getcwd() .. "/", "file")
		end,
	},
	{
		name = "LLDB Debug",
		type = "lldb",
		request = "launch",
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = true,
		program = function()
			return vim.fn.input("Path to executable:", vim.fn.getcwd() .. "/", "file")
		end,
	},
}

------------
---- C# ----
------------

dap.adapters.coreclr = {
	name = "coreclr",
	type = "executable",
	command = vim.fn.exepath("netcoredbg"),
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	name = "C# Debug",
	type = "coreclr",
	request = "launch",
	program = function()
		return vim.fn.input("Path to dll:", vim.fn.getcwd() .. "/bin/Debug/", "file")
	end,
}

------------------
---- Nvim Lua ----
------------------

dap.adapters.nlua = function(callback, config)
	callback({ type = "server", host = config.host or "127.0.0.1" })
end

dap.configurations.lua = {
	name = "Neovim Lua",
	type = "nlua",
	request = "attach",
}

------------------
---- Gdscript ----
------------------

dap.adapters.godot = {
	name = "Godot",
	type = "server",
	host = "127.0.0.1",
	port = 6006,
}

dap.configurations.gdscript = {
	name = "Launch Godot Scene",
	type = "godot",
	request = "launch",
	project = "${workspaceFolder}",
}
