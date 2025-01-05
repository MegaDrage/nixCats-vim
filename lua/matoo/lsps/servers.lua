return {
	clangd = {
		cmd = {
			"clangd",
			"--completion-style=detailed",
			"--function-arg-placeholders",
		},
	},
	lua_ls = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	csharp_ls = {},
	gdscript = {},
	gdshader_lsp = {},
	jdtls = {},
	-- marksman = {},
	nixd = {
		nixpkgs = {
			expr = "import <nixpkgs> { }",
		},
		options = {
			nixos = {
				expr = '(builtins.getFlake"/home/matoo/dotfiles").nixosConfigurations.desktop.options',
			},
			home_manager = {
				expr = '(builtins.getFlake"/home/matoo/dotfiles").homeConfigurations.user.options',
			},
		},
	},
	nil_ls = {},
	rust_analyzer = {},
	texlab = {},
	tinymist = {},
}
