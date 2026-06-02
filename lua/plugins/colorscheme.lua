--return {
--  {
--    "olimorris/onedarkpro.nvim",
--    -- "tanvirtin/monokai.nvim",
--    lazy = false,
--    priority = 1000,
--    config = function()
--      -- require("monokai").setup({ palette = require("monokai") })
--      require("onedarkpro").setup({})
--      vim.cmd("colorscheme onedark_dark")
--    end,
--  },
--}
--
return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        colors = {
          onedark_dark = {
            bg        = "#000000",
            fg        = "#abb2bf",
            red       = "#f42340",
            green     = "#5ddd44",
            yellow    = "#f0b030",
            blue      = "#2090f5",
            purple    = "#cc22e8",
            cyan      = "#0dccd8",
            white     = "#abb2bf",
            black     = "#434852",
            orange    = "#f0b030",
          }
        },
        -- highlights = {
        --  ["@variable"]         = { fg = "${fg}" },
        --  ["@keyword"]          = { fg = "${purple}" },
        --  ["@function"]         = { fg = "${blue}" },
       --   ["@string"]           = { fg = "${green}" },
      --    ["@number"]           = { fg = "${orange}" },
     --     ["@type"]             = { fg = "${yellow}" },
    --      ["@comment"]          = { fg = "${black}" },
   --       ["@constant"]         = { fg = "${cyan}" },
  --        ["@parameter"]        = { fg = "${red}" },
 --       },
        options = {
          transparency = true,
          cursorline = true,
        }
      })
      vim.cmd("colorscheme onedark_dark")
    end,
  },
}
