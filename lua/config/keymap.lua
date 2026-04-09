-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', {
  silent = true
})

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", {
  expr = true,
  silent = true
})
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", {
  expr = true,
  silent = true
})

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.jump(), {
--   desc = 'Go to previous diagnostic message'
-- })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
--   desc = 'Go to next diagnostic message'
-- })

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {
  desc = "[f]ormat"
})

vim.keymap.set("n", "<leader>b", ":Neotree toggle<cr>", {
  desc = "Open Side[b]ar"
})

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>mcprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = "Undo Tree" })
vim.keymap.set('n', '<leader>lg', ":LazyGit<CR>", { desc = "[l]azy [G]it", silent = true })
vim.keymap.set('n', '<leader>gd', ":DiffviewOpen<CR>", { desc = "[G]it [D]iff", silent = true })

-- [[ Nvim-Spider ]]
vim.keymap.set(
  { "n", "o", "x" },
  "w",
  "<cmd>lua require('spider').motion('w')<CR>",
  { desc = "Spider-w" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "e",
  "<cmd>lua require('spider').motion('e')<CR>",
  { desc = "Spider-e" }
)
vim.keymap.set(
  { "n", "o", "x" },
  "b",
  "<cmd>lua require('spider').motion('b')<CR>",
  { desc = "Spider-b" }
)

-- [[ Which Key ]]

-- document existing key chains
require('which-key').add {
  { '<leader>c', group = '[C]ode' },
  { '<leader>g', group = '[G]it' },
  { '<leader>h', group = 'Git [H]unk' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>w', group = '[W]orkspace' },
}

-- Go specific keymaps (only for Go files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    -- Go run
    vim.keymap.set('n', '<leader>gr', '<cmd>GoRun<CR>', opts)
    -- Go build
    vim.keymap.set('n', '<leader>gb', '<cmd>GoBuild<CR>', opts)
    -- Go install
    vim.keymap.set('n', '<leader>gi', '<cmd>GoInstall<CR>', opts)
    -- Generate go.mod
    vim.keymap.set('n', '<leader>gm', '<cmd>GoMod init<CR>', opts)
    -- Tidy go.mod
    vim.keymap.set('n', '<leader>gt', '<cmd>GoMod tidy<CR>', opts)
    -- Get package
    vim.keymap.set('n', '<leader>gp', '<cmd>GoGet<CR>', opts)
    -- Add import
    vim.keymap.set('n', '<leader>ga', '<cmd>GoImport<CR>', opts)
    -- Generate interface stub
    vim.keymap.set('n', '<leader>gs', '<cmd>GoImpl<CR>', opts)
    -- Generate fill struct
    vim.keymap.set('n', '<leader>gf', '<cmd>GoFillStruct<CR>', opts)
    -- Add struct tags
    vim.keymap.set('n', '<leader>gj', '<cmd>GoAddTags<CR>', opts)
    -- Remove struct tags
    vim.keymap.set('n', '<leader>gk', '<cmd>GoRmTags<CR>', opts)
    -- Clear struct tags
    vim.keymap.set('n', '<leader>gc', '<cmd>GoClearTags<CR>', opts)
    -- Go-specific which-key groups
    require('which-key').add {
      { '<leader>g',  group = '[G]o',         buffer = true },
      { '<leader>ga', '[G]o [A]dd Import',    buffer = true },
      { '<leader>gb', '[G]o [B]uild',         buffer = true },
      { '<leader>gc', '[G]o [C]lear Tags',    buffer = true },
      { '<leader>gf', '[G]o [F]ill Struct',   buffer = true },
      { '<leader>gi', '[G]o [I]nstall',       buffer = true },
      { '<leader>gj', '[G]o Add T[a]gs',      buffer = true },
      { '<leader>gk', '[G]o R[m] Tags',       buffer = true },
      { '<leader>gm', '[G]o Go[m]od Init',    buffer = true },
      { '<leader>gp', '[G]o Get Packa[g]e',   buffer = true },
      { '<leader>gr', '[G]o [R]un',           buffer = true },
      { '<leader>gs', '[G]o Generate [S]tub', buffer = true },
      { '<leader>gt', '[G]o [T]idy',          buffer = true },
    }
  end,
})
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').add({
  { '<leader>',  group = 'VISUAL <leader>' },
  { '<leader>h', group = 'Git [H]unk' },
}, {
  mode = 'v'
})
