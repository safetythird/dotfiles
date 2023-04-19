local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsputil = require('lspconfig/util')
-- https://github.com/typescript-language-server/typescript-language-server
lspconfig['tsserver'].setup {
  capabilities = capabilities
}
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#svelte
lspconfig['svelte'].setup {
  capabilities = capabilities
}

lspconfig['gopls'].setup {
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = lsputil.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      staticcheck = true,
    }
  }
}

lspconfig['lua_ls'].setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- https://github.com/neovim/nvim-lspconfig/issues/1700
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}
