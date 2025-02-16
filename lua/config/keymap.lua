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
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {
  desc = 'Go to previous diagnostic message'
})
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {
  desc = 'Go to next diagnostic message'
})

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
  { '<leader>d', group = '[D]ocument' },
  { '<leader>g', group = '[G]it' },
  { '<leader>h', group = 'Git [H]unk' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]oggle' },
  { '<leader>w', group = '[W]orkspace' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').add({
  { '<leader>',  group = 'VISUAL <leader>' },
  { '<leader>h', group = 'Git [H]unk' },
}, {
  mode = 'v'
})
