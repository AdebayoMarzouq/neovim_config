require "nvchad.options"

-- add yours here!

local o = vim.o
local a = vim.api
--
o.cursorlineopt = "both" -- to enable cursorline!
--

--
vim.g.nvimtree_side = "right"
local opts = vim.opt

opts.relativenumber = true
opts.clipboard = "unnamedplus"

-- undo
vim.o.undofile = true

a.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
