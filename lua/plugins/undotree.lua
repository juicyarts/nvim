return {
  'mbbill/undotree',
  config = function()
    -- Save undo history
    -- [[UndoTree]]
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
  end
}
