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
        ["<Tab>"] = { "select_and_accept" },

        -- Shift-Tab moves backward
        ["<S-Tab>"] = { "select_prev" },

        -- Enter inserts newline (not accept)
        ["<CR>"] = { "fallback" },
      },
    },
  },
}
