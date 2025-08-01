return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  build = "make",
  mappings = {
    suggestion = {
      accept = "<D-l>",
      next = "<D-]>",
      prev = "<D-[>",
      dismiss = "<C-]>",
    },
  },
  opts = {
    provider = "claude",
    mode = "agentic",
    repo_map = {
      ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules", ".env", "app.env" }, -- ignore files matching these
    },
    behaviour = {
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      -- enable_cursor_planning_mode = true, -- enable cursor planning mode!
    },
  },
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim",             -- for input provider snacks
    "echasnovski/mini.pick",         -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },
  },
}
