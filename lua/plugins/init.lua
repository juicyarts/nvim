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
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
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
    'nvim-lualine/lualine.nvim',
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
  { 'akinsho/git-conflict.nvim', version = "*", config = true },
}
