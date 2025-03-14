-- [[ Setting options ]]
-- See `:help vim.o`
-- Set highlight on search
vim.o.hlsearch = false
-- Make line numbers default
vim.o.relativenumber = true
vim.o.nu = true
-- Enable mouse mode
vim.o.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'
-- Enable break indent
vim.o.breakindent = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.o.scrolloff = 10
vim.o.hlsearch = false
vim.o.incsearch = true

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.cmdheight = 0
vim.opt.updatetime = 50

-- FMT on save?
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
})


vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  group = vim.api.nvim_create_augroup('gotmpl_highlight', { clear = true }),
  pattern = '*.tmpl',
  callback = function()
    local filename = vim.fn.expand('%:t')
    local ext = filename:match('.*%.(.-)%.tmpl$')

    -- Add more extension to syntax mappings here if you need to.
    local ext_filetypes = {
      go = 'go',
      html = 'html',
      md = 'markdown',
      yaml = 'yaml',
      yml = 'yaml',
    }

    if ext == nil then
      ext = 'go'
    end
    if ext and ext_filetypes[ext] then
      -- Set the primary filetype
      vim.bo.filetype = ext_filetypes[ext]

      -- Define embedded Go template syntax
      vim.cmd([[
        syntax include @gotmpl syntax/gotmpl.vim
        syntax region gotmpl start="{{" end="}}" contains=@gotmpl containedin=ALL
        syntax region gotmpl start="{%" end="%}" contains=@gotmpl containedin=ALL
      ]])
    end
  end,
})
