return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  branch = 'main',
  build = ':TSUpdate',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      branch = 'main',
      lazy = false,
    },
    {
      'nvim-treesitter/nvim-treesitter-context',
      opts = {
        max_lines = 1,
      },
    },
  },
  config = function()
    -- [[ Configure Treesitter ]]
    -- Rewritten nvim-treesitter (main branch): plugin only installs/maintains
    -- parsers+queries; features are enabled via core Neovim APIs per filetype.

    local languages = {
      'go', 'gomod', 'gosum', 'gotmpl',
      'lua', 'python', 'vimdoc', 'vim', 'bash',
      'markdown', 'markdown_inline',
      'javascript', 'typescript', 'tsx',
      'json', 'yaml', 'toml', 'dockerfile',
    }

    -- No-op for languages that are already installed/being installed;
    -- downloads and compiles run async on first setup.
    require('nvim-treesitter').install(languages)

    -- Highlight is core (vim.treesitter.start); indent is staged in the plugin.
    -- The old `highlight`/`indent`/`incremental_selection` modules no longer exist;
    -- the markdown `set-lang-from-info-string!` hack is gone too — the new
    -- markdown queries use standard @injection.language captures.
    vim.api.nvim_create_autocmd('FileType', {
      desc = 'Start tree-sitter highlighting and indentation where queries are available',
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then
          return
        end
        local ok, has_query = pcall(vim.treesitter.query.get, lang, 'highlights')
        if ok and has_query then
          if pcall(vim.treesitter.start) then
            vim.bo[0].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end
      end,
    })

    -- Textobjects: new API — setup table + explicit keymaps (no more `enable = true`).
    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      },
      move = {
        set_jumps = true, -- whether to set jumps in the jumplist
      },
    }

    local select = require('nvim-treesitter-textobjects.select')
    for _, obj in ipairs {
      { 'aa', '@parameter.outer' },
      { 'ia', '@parameter.inner' },
      { 'af', '@function.outer' },
      { 'if', '@function.inner' },
      { 'ac', '@class.outer' },
      { 'ic', '@class.inner' },
    } do
      vim.keymap.set({ 'x', 'o' }, obj[1], function()
        select.select_textobject(obj[2], 'textobjects')
      end, { desc = 'TS textobject ' .. obj[2] })
    end

    local move = require('nvim-treesitter-textobjects.move')
    for _, map in ipairs {
      { ']m', move.goto_next_start, '@function.outer' },
      { ']]', move.goto_next_start, '@class.outer' },
      { ']M', move.goto_next_end, '@function.outer' },
      { '][', move.goto_next_end, '@class.outer' },
      { '[m', move.goto_previous_start, '@function.outer' },
      { '[[', move.goto_previous_start, '@class.outer' },
      { '[M', move.goto_previous_end, '@function.outer' },
      { '[]', move.goto_previous_end, '@class.outer' },
    } do
      vim.keymap.set({ 'n', 'x', 'o' }, map[1], function()
        map[2](map[3], 'textobjects')
      end, { desc = 'TS movement ' .. map[3] })
    end

    local swap = require('nvim-treesitter-textobjects.swap')
    vim.keymap.set('n', '<leader>a', function()
      swap.swap_next '@parameter.inner'
    end, { desc = 'Swap TS node with next' })
    vim.keymap.set('n', '<leader>A', function()
      swap.swap_previous '@parameter.inner'
    end, { desc = 'Swap TS node with previous' })
  end,
}
