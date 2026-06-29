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
          cmd = function(dispatchers, config)
            local root = config.root_dir
            local gemfile = root and (root .. "/Gemfile")
            local has_bundled_lsp = gemfile
              and vim.fn.filereadable(gemfile) == 1
              and vim.fn.system('grep -q "ruby-lsp" ' .. vim.fn.shellescape(gemfile) .. " && echo yes"):match("yes")

            local cmd_parts = has_bundled_lsp
              and { "bundle", "exec", "ruby-lsp" }
              or { "ruby-lsp" }

            return vim.lsp.rpc.start(
              cmd_parts,
              dispatchers,
              config and config.root_dir and { cwd = config.cmd_cwd or config.root_dir }
            )
          end,
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
