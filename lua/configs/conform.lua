local options = {
  formatters_by_ft = {
    -- lua
    lua = { "stylua" },
    -- base web formats (use a sub-list to run only the first available formatter)
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },
    css = { "prettierd", "prettier", stop_after_first = true },
    pcss = { "prettierd", "prettier", stop_after_first = true },
    -- react
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    -- json
    json = { "prettierd", "prettier", stop_after_first = true },
    -- yaml
    yaml = { "prettierd", "prettier", stop_after_first = true },
    -- markdown
    markdown = { "prettierd", "prettier", stop_after_first = true },
    -- python
    python = { "black" },
    c = { "clang-format" },
    sql = { "sqlfluff", "sql-formatter", stop_after_first = true },
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
