local servers = {}
if nixCats('neonixdev') then
  servers.lua_ls = {
    Lua = {
      formatters = {
        ignoreComments = true,
      },
      signatureHelp = { enabled = true },
      diagnostics = {
        globals = { 'nixCats' },
        disable = { 'missing-fields' },
      },
    },
    telemetry = { enabled = false },
    filetypes = { 'lua' },
  }
  if require('nixCatsUtils').isNixCats then
    servers.nixd = {
      nixd = {
        nixpkgs = {
          -- nixd requires some configuration in flake based configs.
          -- luckily, the nixCats plugin is here to pass whatever we need!
          expr = [[import (builtins.getFlake "]] .. nixCats.extra("nixdExtras.nixpkgs") .. [[") { }   ]],
        },
        formatting = {
          command = { "nixfmt" }
        },
        diagnostic = {
          suppress = {
            "sema-escaping-with"
          }
        }
      }
    }
    -- If you integrated with your system flake,
    -- you should pass inputs.self as nixdExtras.flake-path
    -- that way it will ALWAYS work, regardless
    -- of where your config actually was.
    -- otherwise flake-path could be an absolute path to your system flake, or nil or false
    if nixCats.extra("nixdExtras.flake-path") then
      local flakePath = nixCats.extra("nixdExtras.flake-path")
      if nixCats.extra("nixdExtras.systemCFGname") then
        -- (builtins.getFlake "<path_to_system_flake>").nixosConfigurations."<name>".options
        servers.nixd.nixd.options.nixos = {
          expr = [[(builtins.getFlake "]] .. flakePath ..  [[").nixosConfigurations."]] ..
            nixCats.extra("nixdExtras.systemCFGname") .. [[".options]]
        }
      end
      if nixCats.extra("nixdExtras.homeCFGname") then
        -- (builtins.getFlake "<path_to_system_flake>").homeConfigurations."<name>".options
        servers.nixd.nixd.options["home-manager"] = {
          expr = [[(builtins.getFlake "]] .. flakePath .. [[").homeConfigurations."]]
            .. nixCats.extra("nixdExtras.homeCFGname") .. [[".options]]
        }
      end
    end
  else
    servers.rnix = {}
    servers.nil_ls = {}
  end
end

if nixCats('cpp') then
  servers.clangd = {
    cmd = {
      "clangd",
      "--completion-style=detailed",
      "--function-arg-placeholders",
    },
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('nixCats-lsp-attach', { clear = true }),
    callback = function(event)
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      require('myLuaConf.LSPs.caps-on_attach').on_attach(client, event.buf)
      if client ~= nil then
          if client.name == "clangd" then
            require("clangd_extensions.inlay_hints").setup_autocmd()
            require("clangd_extensions.inlay_hints").set_inlay_hints()
          end
      end
    end
  })
  vim.api.nvim_set_keymap('n', '<leader>csi', '<cmd>ClangdSymbolInfo<cr>', { noremap = true, silent = true, desc = '[C]langd [S]ymbol [I]nfo' })
  vim.api.nvim_set_keymap('n', '<leader>cth', '<cmd>ClangdTypeHierarchy<cr>', { noremap = true, silent = true, desc = '[C]langd [T]ype [H]ierarchy' })
end

if nixCats('java') then
  servers.jdtls = {}
end

if nixCats('go') then
  servers.gopls = {}
end

if not require('nixCatsUtils').isNixCats and nixCats('lspDebugMode') then
  vim.lsp.set_log_level("debug")
end

require('lze').load {
  {
    "nvim-lspconfig",
    for_cat = "general.always",
    event = "FileType",
    load = (require('nixCatsUtils').isNixCats and vim.cmd.packadd) or function(name)
      vim.cmd.packadd(name)
      vim.cmd.packadd("mason.nvim")
      vim.cmd.packadd("mason-lspconfig.nvim")
    end,
    after = function(plugin)
      if require('nixCatsUtils').isNixCats then
        for server_name, cfg in pairs(servers) do
          require('lspconfig')[server_name].setup({
            capabilities = require('myLuaConf.LSPs.caps-on_attach').get_capabilities(server_name),
            -- this line is interchangeable with the above LspAttach autocommand
            -- on_attach = require('myLuaConf.LSPs.caps-on_attach').on_attach,
            settings = cfg,
            filetypes = (cfg or {}).filetypes,
            cmd = (cfg or {}).cmd,
            root_pattern = (cfg or {}).root_pattern,
          })
        end
      else
        require('mason').setup()
        local mason_lspconfig = require 'mason-lspconfig'
        mason_lspconfig.setup {
          ensure_installed = vim.tbl_keys(servers),
        }
        mason_lspconfig.setup_handlers {
          function(server_name)
            require('lspconfig')[server_name].setup {
              capabilities = require('myLuaConf.LSPs.caps-on_attach').get_capabilities(server_name),
              -- this line is interchangeable with the above LspAttach autocommand
              -- on_attach = require('myLuaConf.LSPs.caps-on_attach').on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            }
          end,
        }
      end
    end,
  }
}
