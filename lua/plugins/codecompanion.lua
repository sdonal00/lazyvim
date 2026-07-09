-- ~/.config/nvim/lua/plugins/codecompanion.lua

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      http = {
        qwen35 = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "qwen35",
            env = {
              url = "http://10.0.0.72:11434", -- change to LAN IP if calling from another machine
            },
            schema = {
              model = {
                default = "hf.co/unsloth/Qwen3.5-9B-GGUF:Q4_K_M", -- paste exact name from `ollama list`
              },
              num_ctx = {
                default = 16384,
              },
            },
          })
        end,
      },
    },

    interactions = {
      chat = { adapter = "qwen35" },
      inline = { adapter = "qwen35" },
      cmd = { adapter = "qwen35" },
    },

    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
  keys = {
    { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
    { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
    { "<leader>ae", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "CodeCompanion Inline Edit" },
  },
}
