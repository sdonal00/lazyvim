return {
  -- Disable rubocop and prism from LazyVim ruby extra
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "ruby_lsp" },
      handlers = {
        rubocop = function() end,
        prism = function() end,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rubocop = { enabled = false },
        prism = { enabled = false },
        ruby_lsp = {
          enabled = true,
          init_options = {
            formatter = "standard",
            linters = { "standard" },
            enabledFeatures = {
              diagnostics = true,
              formatting = true,
            },
          },
        },
      },
    },
  },
}
