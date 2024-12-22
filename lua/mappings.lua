require "nvchad.mappings"
local wk = require "which-key"
local harpoon = require "harpoon"
local dap, dapui = require "dap", require "dapui"
local options = { noremap = true, silent = true }
local map = vim.keymap.set

local merge = function(a)
  local c = {}
  for k, v in pairs(a) do
    c[k] = v
  end
  for k, v in pairs(options) do
    c[k] = v
  end
  return c
end

local clear_qf_list = function()
  vim.fn.setqflist {}
  vim.cmd "cclose"
end

local remove_qf_entry = function(index)
  local qflist = vim.fn.getqflist()
  table.remove(qflist, index)
  vim.fn.setqflist(qflist)
  vim.cmd "copen"
end

local remove_current_qf_entry = function()
  local current_qf_index = vim.fn.getqflist({ idx = 0 }).idx
  remove_qf_entry(current_qf_index)
end

local jump_to_qf_index_input = function()
  local index = vim.fn.input "Enter Quickfix Index: "
  vim.cmd("cc " .. index)
end

-- Unecessary keymaps
vim.api.nvim_del_keymap("n", "<leader>h")
vim.api.nvim_del_keymap("n", "<leader>v")

-- Basic mappings
map("n", ";", ":", merge { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>", merge({ desc = ""}))
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>", merge { desc = "Save file" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", merge { desc = "Move line/block up (I)" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", merge { desc = "Move line/block down (I)" })
map("n", "<A-j>", ":m .+1<CR>==", merge { desc = "Move line up (N)" })
map("n", "<A-k>", ":m .-2<CR>==", merge { desc = "Move line down (N)" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", merge { desc = "Move line up (V)" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", merge { desc = "Move line down (V)" })

-- Blackhole delete
map({ "n", "x", "v", "o" }, "<leader>d", '"_d', merge { desc = "Delete without yanking" })

-- Undotree
wk.add {
  {
    "<leader>u",
    function()
      vim.cmd.UndotreeToggle()
      vim.cmd.UndotreeFocus()
    end,
    desc = "Toggle Undo Tree",
    mode = { "n" },
  },
}

-- Harpoon setup
harpoon.setup()

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table {
        results = file_paths,
      },
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
    })
    :find()
end

wk.add {
  { "<leader>h", group = "harpoon" },
  {
    "<leader>hl",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "View harpoon list",
  },
  {
    "<leader>ha",
    function()
      harpoon:list():add()
    end,
    desc = "Add file to harpoon",
  },
  {
    "<leader>hr",
    function()
      harpoon:list():remove()
    end,
    desc = "Remove file from harpoon",
  },
  {
    "<leader>hc",
    function()
      harpoon:list():clear()
    end,
    desc = "Clear harpoon",
  },
  {
    "<leader>hm",
    function()
      toggle_telescope(harpoon:list())
    end,
    desc = "View harpoon list in telescope",
  },
  {
    "<leader>hp",
    function()
      harpoon:list():prev()
    end,
    desc = "Move to previous buffer in harpoon",
  },
  {
    "<leader>hn",
    function()
      harpoon:list():next()
    end,
    desc = "Move to next buffer in harpoon",
  },
}

-- Spectre key mappings
wk.add {
  { "<leader>S", group = "Spectre" },
  {
    "<leader>St",
    '<cmd>lua require("spectre").toggle()<CR>',
    desc = "Toggle Spectre",
  },
  {
    "<leader>Sw",
    '<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
    desc = "Search current word",
  },
  {
    "<leader>Sf",
    '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
    desc = "Search on current file",
  },
}

-- Visual Multi key mappings
local function visual_cursors_with_delay()
  vim.cmd 'silent! execute "normal! \\<Plug>(VM-Visual-Cursors)"'
  vim.cmd "sleep 200m"
  vim.cmd 'silent! execute "normal! A"'
end

wk.add {
  { "<leader>m", group = "Visual Multi" },
  {
    "<leader>ms",
    "<Plug>(VM-Select-All)<Tab>",
    desc = "Select all matching words",
    mode = { "n" },
  },
  {
    "<leader>mr",
    "<Plug>(VM-Start-Regex-Search)",
    desc = "Start regex search",
    mode = { "n" },
  },
  {
    "<leader>mp",
    "<Plug>(VM-Add-Cursor-At-Pos)",
    desc = "Add cursor at pos",
    mode = { "n" },
  },
  {
    "<leader>mv",
    visual_cursors_with_delay,
    desc = "Visual cursors",
    mode = { "v" },
  },
  {
    "<leader>mo",
    "<Plug>(VM-Toggle-Mappings)",
    desc = "Toggle Mapping",
    mode = { "n" },
  },
}

-- Refactoring key mappings
wk.add {
  { "<leader>r", group = "Refactoring" },
  {
    "<leader>re",
    function()
      require("refactoring").refactor "Extract Function"
    end,
    desc = "Extract Function",
    mode = "x",
  },
  {
    "<leader>rf",
    function()
      require("refactoring").refactor "Extract Function To File"
    end,
    desc = "Extract Function To File",
    mode = "x",
  },
  {
    "<leader>rv",
    function()
      require("refactoring").refactor "Extract Variable"
    end,
    desc = "Extract Variable",
    mode = "x",
  },
  {
    "<leader>rI",
    function()
      require("refactoring").refactor "Inline Function"
    end,
    desc = "Inline Function",
    mode = "n",
  },
  {
    "<leader>ri",
    function()
      require("refactoring").refactor "Inline Variable"
    end,
    desc = "Inline Variable",
    mode = { "n", "x" },
  },
  {
    "<leader>rb",
    function()
      require("refactoring").refactor "Extract Block"
    end,
    desc = "Extract Block",
    mode = "n",
  },
  {
    "<leader>rbf",
    function()
      require("refactoring").refactor "Extract Block To File"
    end,
    desc = "Extract Block to File",
    mode = "n",
  },
}

wk.add {
  { "<leader>q", group = "+quickfix" },
  { "<leader>qo", "<cmd>copen<cr>", desc = "Open Quickfix List" },
  { "<leader>qc", "<cmd>cclose<cr>", desc = "Close Quickfix List" },
  { "<leader>qn", "<cmd>cnext<cr>", desc = "Next Quickfix Item" },
  { "<leader>qp", "<cmd>cprev<cr>", desc = "Previous Quickfix Item" },
  { "<leader>ql", "<cmd>clist<cr>", desc = "Show Quickfix List" },
  {
    "<leader>qd",
    function()
      remove_current_qf_entry()
    end,
    desc = "Remove Current Quickfix Entry",
  },
  {
    "<leader>qx",
    function()
      clear_qf_list()
    end,
    desc = "Clear Quickfix List",
  },
  {
    "<leader>qj",
    function()
      jump_to_qf_index_input()
    end,
    desc = "Jump to Specific Quickfix Index",
  },
}

-- Notes key mappings
wk.add {
  { "<leader>t", group = "Notes" },
  {
    "<leader>td",
    "<cmd>Tdo<cr>",
    desc = "Today's Todo",
  },
  {
    "<leader>te",
    "<cmd>TdoEntry<cr>",
    desc = "Today's Entry",
  },
  {
    "<leader>tf",
    "<cmd>TdoFiles<cr>",
    desc = "All Notes",
  },
  {
    "<leader>tg",
    "<cmd>TdoFind<cr>",
    desc = "Find Notes",
  },
  {
    "<leader>ty",
    "<cmd>Tdo -1<cr>",
    desc = "Yesterday's Todo",
  },
  {
    "<leader>tj",
    "<cmd>put =strftime('%a %d %b %r')<cr>",
    desc = "Insert Human Date",
  },
  {
    "<leader>tJ",
    "<cmd>put =strftime('%F')<cr>",
    desc = "Insert Date",
  },
  {
    "<leader>tk",
    "<cmd>put =strftime('%r')<cr>",
    desc = "Insert Human Time",
  },
  {
    "<leader>tK",
    "<cmd>put =strftime('%F-%H-%M')<cr>",
    desc = "Insert Time",
  },
  {
    "<leader>tl",
    "<cmd>Tdo 1<cr>",
    desc = "Tomorrow's Todo",
  },
  {
    "<leader>tn",
    "<cmd>TdoNote<cr>",
    desc = "New Note",
  },
  {
    "<leader>ts",
    '<cmd>lua require("tdo").run_with("commit " .. vim.fn.expand("%:p")) vim.notify("Commited!")<cr>',
    desc = "Commit Note",
  },
  {
    "<leader>ti",
    "<cmd>TdoTodos<cr>",
    desc = "Incomplete Todos",
  },
  {
    "<leader>tx",
    "<cmd>TdoToggle<cr>",
    desc = "Toggle Todo",
  },
}

-- dap
wk.add {
  { "<leader>p", group = "harpoon" },
  {
    "<leader>pt",
    ":DapUiToggle<CR>",
    desc = "Open debugger",
  },
  {
    "<leader>pb",
    dap.toggle_breakpoint,
    desc = "Toggle debugger breakpoint",
  },
  {
    "<leader>pc",
    dap.continue,
    desc = "Continue debugging",
  },
  {
    "<leader>pr",
    ":lua require('dapui').open({reset = true})<CR>",
    desc = "Reset debugger",
  },
}
