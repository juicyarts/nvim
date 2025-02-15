return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = "*", -- set this to "*" if you want to always pull the latest change, false to update on release
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
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
      auto_suggestions_provider = "copilot",
      -- gemini = {
      --   -- @see https://ai.google.dev/gemini-api/docs/models/gemini
      --   model = "gemini-2.0-flash-001",
      --   -- model = "gemini-1.5-flash",
      -- },
      -- provider = "deepseek",
      -- vendors = {
      --   deepseek = {
      --     __inherited_from = "openai",
      --     api_key_name = "",
      --     endpoint = "http://127.0.0.1:11434/v1",
      --     model = "deepseek-r1:8b"
      --   }
      -- }
    },
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
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
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
}
