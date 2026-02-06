return {
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        go = 'go',              -- go command
        goimport = 'goimports', -- goimport command
        gofmt = 'gofumpt',      -- gofmt command
        max_line_len = 120,
        tag_transform = 'camelcase',
        test_dir = '',
        comment_placeholder = '  ',
        icons = { breakpoint = '🧘', currentpos = '🏃' },
        verbose = false,
        log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
        lsp_cfg = false,      -- handle lsp config ourselves
        lsp_gofumpt = true,
        lsp_on_attach = true, -- use on_attach from go.nvim
        lsp_codelens = true,
        lsp_diag_hdlr = true,
        lsp_diag_underline = true,
        lsp_diag_virtual_text = true,
        lsp_document_formatting = true,
        -- set to true to use lsp.format() for formatting
        gopls_cmd = nil, -- you can provide gopls path and args
        gopls_remote_auto = true,
        gocoverage_spinner = '⚙️',
        fillstruct = 'gopls',
        gotests = nil,
        gotest_template_dir = nil,
        gotest_template = nil,
        textobjects = true,
        test_runner = 'go', -- one of {`go`, `richgo`, `delve`, `ginkgo`}
        verbose_tests = true,
        run_in_floating = false,
        floating_win_width = 0.8,
        floating_win_height = 0.9,
        floaterm = { border = 'double' },
        go_fmt_command = "gofumpt",
      })

      -- Run gofmt on save
      local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          require('go.format').gofmt()
        end,
        group = format_sync_grp,
      })
    end,
    event = { "CmdlineEnter" },
    ft = { "go", 'gomod' },
  }
}

