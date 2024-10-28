local options = {
  formatters_by_ft = {
    -- lua
    lua = { "stylua" },
    -- base web formats (use a sub-list to run only the first available formatter)
    javascript = { { "prettierd", "prettier" } },
    typescript = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    css = { { "prettierd", "prettier" } },
    pcss = { { "prettierd", "prettier" } },
    -- react
    javascriptreact = { { "prettierd", "prettier" } },
    typescriptreact = { { "prettierd", "prettier" } },
    -- json
    json = { { "prettierd", "prettier" } },
    -- yaml
    yaml = { { "prettierd", "prettier" } },
    -- markdown
    markdown = { { "prettierd", "prettier" } },
    -- python
    python = { "black" },
    c = { "clang-format" },
    sql = { { "sqlfluff", "sql-formatter" } },
    -- everything else will use lsp format
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   lsp_fallback = true,
  --   async = false,
  --   timeout_ms = 500,
  -- },
}

local conform = require "conform"
conform.setup(options)

-- vim.keymap.set({ "n", "v" }, "<leader>mp", function()
--   conform.format {
--     -- These options will be passed to conform.format()
--     lsp_fallback = true,
--     async = false,
--     timeout_ms = 500,
--   }
-- end, { desc = "Format file or range (in visual mode)" })
