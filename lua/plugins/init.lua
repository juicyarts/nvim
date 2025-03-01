return {
  'tpope/vim-sleuth',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'joerdav/templ.vim',
  'sindrets/diffview.nvim',
  'nvim-tree/nvim-web-devicons',
  'aznhe21/actions-preview.nvim',
  'gpanders/editorconfig.nvim',
  'folke/which-key.nvim',
  'nvim-lua/plenary.nvim',
  {
    'stevearc/overseer.nvim',
    opts = {},
    config = function()
      require('overseer').setup()
    end
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-neotest/neotest-plenary",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-vim-test",
      "orjangj/neotest-ctest",
      { "fredrikaverpil/neotest-golang", version = "*" },
    },
    keys = function()
      local neotest = require("neotest")

      return {
        { "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, desc = "Run File" },
        { "<leader>tt", function() neotest.run.run() end,                   desc = "Run Nearest" },
        { "<leader>tw", function() neotest.run.run(vim.loop.cwd()) end,     desc = "Run Workspace" },
        {
          "<leader>tr",
          function()
            -- This will only show the output from the test framework
            neotest.output.open({ short = true, auto_close = true })
          end,
          desc = "Results (short)",
        },
        {
          "<leader>tR",
          function()
            -- This will show the classic CTest log output.
            -- The output usually spans more than can fit the neotest floating window,
            -- so using 'enter = true' to enable normal navigation within the window
            -- is recommended.
            neotest.output.open({ enter = true })
          end,
          desc = "Results (full)",
        },
        -- Other keybindings
      }
    end,
    config = function()
      -- Optional, but recommended, if you have enabled neotest's diagnostic option
      local neotest_ns = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Convert newlines, tabs and whitespaces into a single whitespace
            -- for improved virtual text readability
            local message = diagnostic.message:gsub("[\r\n\t%s]+", " ")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup({
        adapters = {
          require("neotest-plenary"),
          -- require("neotest-golang"),
          require("neotest-ctest").setup({}),
        },
      })
    end
  },
  {
    -- Make sure to setup it properly if you have lazy=true
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    "chrisgrieser/nvim-spider",
    lazy = true,
    config = function()
      require('spider').setup({
        skipInsignificantPunctuation = false
      })
    end
  },
  {
    'folke/trouble.nvim',
    opts = {
      focus = true
    },
    cmd = "Trouble",
    keys = {
      {
        "<leader>q",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    opts = {},
    keys = {
      {
        mode = "n",
        "<leader>st",
        "<cmd>lua require('spectre').toggle()<CR>",
      },
    },
    config = function()
      require("spectre").setup({
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = {
              "-i",
              "",
              "-E",
            },
          },
        },
      })
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      presets = {
        lsp_doc_border = true,
      },
      lsp = {
        progress = {
          enabled = false,
        },
        hover = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      notify = {
        view = "mini",
      },
      routes = {
        {
          filter = {
            event = "notify",
            find = "No information available",
          },
          opts = { skip = true },
        },
      },
    },
  },
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'dracula-nvim',
        component_separators = '|',
        section_separators = ''
      }
    }
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
    config = function()
      require("ibl").setup()
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {}
  },
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme 'dracula'
    end
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("lazygit")
    end,
  },
  {
    -- fast switch buffer
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup()
    end
  },
}
