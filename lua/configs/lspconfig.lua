-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "ts_ls",
  "svelte",
  "tailwindcss",
  "eslint",
  "sqlls",
  "gopls",
  "pylsp",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.ts_ls.setup {
  settings = {
    implicitProjectConfiguration = {
      checkJs = true,
    },
  },
}

lspconfig.svelte.setup {
  filetypes = { "svelte" },
  on_attach = function(client, bufnr)
    if client.name == "svelte" then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.svelte" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
    if vim.bo[bufnr].filetype == "svelte" then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.svelte" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
  end,
}

lspconfig.sqls.setup {
  filetypes = { "sql", "mysql" },
  sqls = {
    connections = {
      -- {
      --   driver = "mysql",
      --   dataSourceName = "root:root@tcp(127.0.0.1:3306)/adv_sql",
      -- },
      {
        driver = "mysql",
        dataSourceName = "host=127.0.0.1 port=3306 user=root password=created4Python/ dbname=adv_sql sslmode=disable",
      },
    },
  },
}
