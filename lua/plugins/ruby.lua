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
            local gemfile = vim.fn.expand("~/.config/nvim/ruby-lsp/Gemfile")
            local gemfile_dir = vim.fn.fnamemodify(gemfile, ":h")

            -- Copy current environment and point BUNDLE_GEMFILE at the
            -- standalone Gemfile, so the project repo is never touched.
            local env = vim.fn.environ()
            env.BUNDLE_GEMFILE = gemfile

            -- local env_list = {}
            -- for k, v in pairs(env) do
            --   table.insert(env_list, k .. "=" .. tostring(v))
            -- end

            return vim.lsp.rpc.start(
              { "bundle", "exec", "ruby-lsp" },
              dispatchers,
              {
                cwd = gemfile_dir,
                env = env,
              }
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
