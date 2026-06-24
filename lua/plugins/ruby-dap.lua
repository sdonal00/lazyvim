return {
  "mfussenegger/nvim-dap",
  optional = true,
  config = function()
    local dap = require("dap")

    ----------------------------------------------------------------------
    -- ADAPTER
    -- rdbg only speaks DAP over a TCP server, so this must branch:
    --   * "attach"  -> we just connect to a port someone already opened
    --                  (e.g. rails/sidekiq started with RUBY_DEBUG_OPEN=true)
    --   * "launch"  -> nvim-dap spawns `rdbg --open --port <port> -- <cmd>`
    --                  itself, then connects to that same port
    ----------------------------------------------------------------------
    dap.adapters.ruby = function(callback, config)
      if config.request == "attach" then
        callback({
          type = "server",
          host = "127.0.0.1",
          port = config.port,
        })
      else
        -- Build "RAILS_ENV=foo bundle exec rdbg ... -- command args"
        -- as a single shell command so the env var applies to the
        -- spawned process without touching nvim-dap's options.env
        -- (which has a known bug where setting it wipes the rest
        -- of the inherited environment instead of merging).
        local env_prefix = ""
        if config.railsEnv and config.railsEnv ~= "" then
          env_prefix = "RAILS_ENV=" .. config.railsEnv .. " "
        end

        local cmd_parts = { "bundle", "exec", config.command }
        for _, a in ipairs(config.commandArgs or {}) do
          table.insert(cmd_parts, a)
        end

        callback({
          type = "server",
          host = "127.0.0.1",
          port = "${port}",
          executable = {
            command = "sh",
            args = {
              "-c",
              env_prefix
                .. "rdbg --open --port ${port} --command -- "
                .. table.concat(cmd_parts, " "),
            },
          },
        })
      end
    end

    ----------------------------------------------------------------------
    -- CONFIGURATIONS
    ----------------------------------------------------------------------
    dap.configurations.ruby = {
      ------------------------------------------------------------------
      -- 1. ATTACH: Rails (start it yourself with
      --    RAILS_ENV=test RUBY_DEBUG_OPEN=true RUBY_DEBUG_PORT=38697 bin/rails s,
      --    then DapContinue + pick this config)
      ------------------------------------------------------------------
      {
        type = "ruby",
        name = "Attach to Rails",
        request = "attach",
        localfs = true,
        port = 38697,
      },
      ------------------------------------------------------------------
      -- 2. ATTACH: Sidekiq (RUBY_DEBUG_OPEN=true RUBY_DEBUG_PORT=38699 bundle exec sidekiq)
      ------------------------------------------------------------------
      {
        type = "ruby",
        name = "Attach to Sidekiq",
        request = "attach",
        localfs = true,
        port = 38699,
      },
      ------------------------------------------------------------------
      -- 3. RAKE: nvim-dap launches rdbg + the rake task for you
      ------------------------------------------------------------------
      {
        type = "ruby",
        name = "Debug Rake Task (namespace:task)",
        request = "launch",
        localfs = true,
        command = "rake",
        commandArgs = function()
          local task = vim.fn.input("Rake task namespace:task: ")
          return { task }
        end,
        railsEnv = function()
          return vim.fn.input("RAILS_ENV: ", "staging")
        end,
      },
      ------------------------------------------------------------------
      -- 4. CURRENT FILE
      ------------------------------------------------------------------
      {
        type = "ruby",
        name = "Debug current Ruby file",
        request = "launch",
        localfs = true,
        command = "ruby",
        commandArgs = { "${file}" },
        railsEnv = function()
          return vim.fn.input("RAILS_ENV: ", "staging")
        end,
      },
      ------------------------------------------------------------------
      -- 5. RSPEC FILE
      ------------------------------------------------------------------
      {
        type = "ruby",
        name = "Run current spec file",
        request = "launch",
        localfs = true,
        command = "rspec",
        commandArgs = { "${file}" },
        railsEnv = function()
          return vim.fn.input("RAILS_ENV: ", "test")
        end,
      },
      ------------------------------------------------------------------
      -- 6. ALL SPECS
      ------------------------------------------------------------------
      {
        type = "ruby",
        name = "Run all specs",
        request = "launch",
        localfs = true,
        command = "rspec",
        commandArgs = { "." },
        railsEnv = function()
          return vim.fn.input("RAILS_ENV: ", "test")
        end,
      },
    }
  end,
}
