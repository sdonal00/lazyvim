return {
  {
    "olimorris/onedarkpro.nvim",
    -- "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- require("monokai").setup({ palette = require("monokai") })
      require("onedarkpro").setup({})
      vim.cmd("colorscheme onedark_dark")
    end,
  },
}
