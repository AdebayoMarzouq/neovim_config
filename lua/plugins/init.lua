return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"

      require("dapui").setup()
      require("dap-go").setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      require "plugins.custom.null-ls"
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { side = "right" },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "isort",
        "black",
        "typescript-language-server",
        "svelte-language-server",
        "html-lsp",
        "css-lsp",
        "prettierd",
        "tailwindcss-language-server",
        "eslint-lsp",
        "gopls",
        "sql-language-server",
        "eslint_d",
        "pylint",
        "pylsp",
        "sqlfluff",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
      ensure_installed = {
        --- Documentation parsers
        "vimdoc",
        "jsdoc",
        "comment",
        "regex",

        --- Web Development
        "html",
        "css",
        "svelte",
        "typescript",
        "javascript",
        "tsx",

        --- Languages
        "go",
        "rust",
        "python",
        "c",

        --- Database
        "sql",

        --- Scripting & Automation
        "vim",
        "vimdoc",
        "lua",
        "query",

        --- Markup & data
        "json",
        "yaml",
        "toml",
        "xml",
        "graphql",
        "markdown",
        "markdown_inline",

        --- System/Shell
        "bash",
        "dockerfile",
      },

      sync_install = false,
      auto_install = true,

      highlight = {
        enable = true,
      },
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = " <author> • <summary> • <<sha>> • <date>",
      date_format = "%r",
      virtual_text_column = 1,
      message_when_not_committed = "You no commit am nii?",
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "html",
      "svelte",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ["Find under"] = "",
      }
      vim.g.VM_add_cursor_at_pos_no_mappings = 1
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufEnter",
  },
  {
    "mbbill/undotree",
    event = "BufEnter",
  },
  {
    "2kabhishek/tdo.nvim",
    event = "VeryLazy",
    dependencies = "nvim-telescope/telescope.nvim",
    cmd = { "Tdo", "TdoEntry", "TdoNote", "TdoTodos", "TdoToggle", "TdoFind", "TdoFiles" },
  },
  {
    "tjdevries/luai.nvim",
    cmd = { "LuaiGenerate" },
    config = function()
      require("luai").setup {
        token = "ANTHROPIC_TOKEN",
      }
    end,
    opts = {
      enabled = true,
    },
  },
  {
    -- Enhanced TODO comments
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    dir = "~/Documents/Development/personal/ME/my_plugins/scratch_buffer/",
    name = "scratch_buffer",
    event = "BufEnter",
    config = function()
      require "scratch_buffer"
    end,
  },
}
