return {
	{ "cmp_luasnip" },
	-- { "cmp-buffer" },
	{ "cmp-path" },
	{ "cmp-nvim-lsp" },
	{ "cmp-nvim-lua" },
	{ "cmp-nvim-lsp-signature-help" },
	{
		"friendly-snippets",
		dep_of = "nvim-cmp",
	},
	{
		"lspkind.nvim",
		dep_of = "nvim-cmp",
		symbol_map = {
			Text = "󰉿",
			Method = "󰆧",
			Function = "󰊕",
			Constructor = "",
			Field = "󰜢",
			Variable = "󰀫",
			Class = "󰠱",
			Interface = "",
			Module = "",
			Property = "󰜢",
			Unit = "󰑭",
			Value = "󰎠",
			Enum = "",
			Keyword = "󰌋",
			Snippet = "",
			Color = "󰏘",
			File = "󰈙",
			Reference = "󰈇",
			Folder = "󰉋",
			EnumMember = "",
			Constant = "󰏿",
			Struct = "󰙅",
			Event = "",
			Operator = "󰆕",
			TypeParameter = "",
		},
	},
	{
		"luasnip",
		dep_of = "nvim-cmp",
		after = function()
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			luasnip.config.setup {}
			local ls = require("luasnip")
			vim.keymap.set({"i","s" }, "<M-n>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end)
		end,
	},
	{
		"nvim-cmp",
		event = "DeferredUIEnter",
		on_require = "cmp",
		-- this is a bit of a hack. cmp_luasnips needs to load after nvim-cmp
		-- i dont really want to get into learning nixcats-utils right now
		-- instead I can just make nvim-cmp a dependency of cmp_luasnips
		-- todo: clean this up
		dep_of = "cmp_luasnip",
		after = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")
			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},
				formatting = {
					format = lspkind.cmp_format {
						mode = "symbol_text",
						with_text = true,
						maxwidth = 50,
						ellipsis_char = "...",
						menu = {
							buffer = "[BUF]",
							nvim_lsp = "[LSP]",
							nvim_lsp_lua = "[VIM]",
							path = "[PATH]",
							cmp_luasnip = "[SNIP]",
						}
					},
				},
				completion = {completeopt = "menu,menuone,preview"},
				experimental = {
					ghost_text=false,
					native_menu = false,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert {
					["<c-p>"] = cmp.mapping.scroll_docs(-4),
					["<c-n>"] = cmp.mapping.scroll_docs(4),
					["<c-Space>"] = cmp.mapping.complete(),
					["<cr>"] = cmp.mapping.confirm {
						behaviour = cmp.ConfirmBehavior.Replace,
						select = true,
					},
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { 'i', 's' }),
					['<S-Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { 'i', 's' }),
				},
				enabled = function()
					return vim.bo[0].buftype ~= "prompt"
				end,
				sources = cmp.config.sources {
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_lua" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "path" },
					{ name = "luasnip" },
					-- { name = "buffer" },
				},
			}
		end,
	},
}
