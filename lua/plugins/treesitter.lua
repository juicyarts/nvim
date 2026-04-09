return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      "nvim-treesitter/nvim-treesitter-context",
      opts = {
        max_lines = 1,
      },
    },
  },
  build = ':TSUpdate',
  config = function()
    -- [[ Configure Treesitter ]]
    -- See `:help nvim-treesitter`

    -- Fix for markdown injection crash: override directive with safe handler
    -- Keeps markdown highlighting while skipping broken injection nodes
    local markdown_aliases = {
      ex = "elixir",
      pl = "perl",
      sh = "bash",
      uxn = "uxntal",
      ts = "typescript",
    }

    local function get_parser_from_markdown_info_string(injection_alias)
      local match = vim.filetype.match({ filename = "a." .. injection_alias })
      return match or markdown_aliases[injection_alias] or injection_alias
    end

    vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
      local capture_id = pred[2]
      local node = match[capture_id]
      if not node then
        return
      end
      local ok, text = pcall(vim.treesitter.get_node_text, node, bufnr)
      if not ok or not text then
        return
      end
      metadata["injection.language"] = get_parser_from_markdown_info_string(text:lower())
    end, { force = true })

    -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
    vim.defer_fn(function()
      require('nvim-treesitter.configs').setup {
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = { 
          'go', 'gomod', 'gosum', 'gotmpl',
          'lua', 'python', 'vimdoc', 'vim', 'bash', 
          'markdown', 'markdown_inline', 
          'javascript', 'typescript', 'tsx',
          'json', 'yaml', 'toml', 'dockerfile'
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,

        highlight = {
          enable = true
        },
        indent = {
          enable = true
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>'
          }
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner'
            }
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              [']m'] = '@function.outer',
              [']]'] = '@class.outer'
            },
            goto_next_end = {
              [']M'] = '@function.outer',
              [']['] = '@class.outer'
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[['] = '@class.outer'
            },
            goto_previous_end = {
              ['[M'] = '@function.outer',
              ['[]'] = '@class.outer'
            }
          },
          swap = {
            enable = true,
            swap_next = {
              ['<leader>a'] = '@parameter.inner'
            },
            swap_previous = {
              ['<leader>A'] = '@parameter.inner'
            }
          }
        }
      }
    end, 0)
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false
          }
        }
      }
    }
  end
}
