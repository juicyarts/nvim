return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  opts = {
    ensure_installed = {
      -- Go tools
      "gopls",
      "gofumpt",
      "goimports",
      "golines",
      "staticcheck",
      "revive",
      "gomodifytags",
      "impl",
      -- TypeScript/JavaScript
      "typescript-language-server",
      "eslint-lsp",
      "prettierd",
      -- Lua
      "stylua",
      -- JSON/JSONC
      "jq",
      -- Other
      "clangd",
      "clang-format",
    }
  }
}
