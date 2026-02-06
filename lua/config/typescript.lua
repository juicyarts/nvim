-- TypeScript/JavaScript specific configuration
return {
  -- Configure formatting for TypeScript/JavaScript files
  setup = function()
    -- Set up file type detection
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
      pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
      callback = function()
        -- Use prettier for formatting if available, otherwise fallback to LSP
        local format_options = {
          timeout_ms = 2000,
          filter = function(client)
            -- Prefer prettier if available
            if client.name == "prettierd" then
              return true
            end
            -- Fallback to TypeScript language server
            return client.name == "ts_ls"
          end,
        }
        -- Set up buffer-local formatting
        vim.b.format_options = format_options
      end,
    })

    -- TypeScript/JavaScript specific keymaps
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      callback = function()
        -- Organize imports
        vim.keymap.set('n', '<leader>oi', function()
          vim.lsp.buf.code_action({
            context = {
              only = { "source.organizeImports.ts" },
              diagnostics = {},
            },
            apply = true,
          })
        end, { buffer = true, desc = "[O]rganize [I]mports" })

        -- Rename file (requires ts_ls with workspace capabilities)
        vim.keymap.set('n', '<leader>rf', function()
          local old_name = vim.fn.expand('%:t')
          local new_name = vim.fn.input('New name: ', old_name)
          if new_name and new_name ~= old_name then
            vim.lsp.buf.execute_command({
              command = '_typescript.applyRenameFile',
              arguments = {
                {
                  sourceUri = vim.uri_from_fname(vim.fn.expand('%:p')),
                  targetUri = vim.uri_from_fname(vim.fn.expand('%:p:h') .. '/' .. new_name),
                },
              },
            })
          end
        end, { buffer = true, desc = "[R]ename [F]ile" })
      end,
    })

    -- Configure completion for TypeScript/JavaScript
    local cmp = require('cmp')
    cmp.setup.filetype({ "typescript", "typescriptreact", "javascript", "javascriptreact" }, {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lua' },
      },
      mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
        ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }),
        ['<C-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      },
    })
  end,
}

