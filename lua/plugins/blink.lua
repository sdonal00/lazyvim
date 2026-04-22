return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        ghost_text = {
          enabled = false,
        },
      },
      keymap = {
        preset = "default",

        -- Tab confirms completion
       -- ["<Tab>"] = { "select_and_accept" },

        -- Shift-Tab moves backward
        --["<S-Tab>"] = { "select_prev" },

        -- Enter inserts newline (not accept)
        --["<CR>"] = { "fallback" },

        -- Enter confirms completion
        --["<CR>"] = { "accept", "fallback" },

        ["<Tab>"]   = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<CR>"] = { "accept", "fallback" },      
      },
    },
  },
}
