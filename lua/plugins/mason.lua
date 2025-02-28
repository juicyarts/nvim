return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim', -- Useful status updates for LSP
  },
  opts = {
    ensure_installed = {
      "go",
      "clangd",
      "clang-format",
      "codelldb",
    }
  }
}
