return {
{
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local mode_colors = {
  n = Snacks.util.color("Function"),
  i = Snacks.util.color("String"),
  v = Snacks.util.color("Keyword"),
  V = Snacks.util.color("Keyword"),
  ["\22"] = Snacks.util.color("Keyword"),
  c = Snacks.util.color("Constant"),
  R = Snacks.util.color("DiagnosticError"),
}

    local opts = {
      options = {
	theme = {
    normal = {
      a = { fg = mode_colors.n, bg = "none" },
      b = { bg = "none" },
      c = { bg = "none" },
      x = { bg = "none" },
      y = { bg = "none" },
      z = { bg = "none" },
    },
    insert = { a = { fg = mode_colors.i, bg = "none" } },
    visual = { a = { fg = mode_colors.v, bg = "none" } },
    command = { a = { fg = mode_colors.c, bg = "none" } },
    replace = { a = { fg = mode_colors.R, bg = "none" } },
  },
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
	component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
	lualine_a = {
  {
    function()
      local mode_map = {
        n = "NORMAL", i = "INSERT", v = "VISUAL", V = "V-LINE",
        ["\22"] = "V-BLOCK", c = "COMMAND", R = "REPLACE", t = "TERMINAL"
      }
      return "[" .. (mode_map[vim.fn.mode()] or vim.fn.mode()) .. "]"
    end,
    color = function()
      local mode_colors = {
        n = "#61afef",   -- blue
        i = "#98c379",   -- green
        v = "#c678dd",   -- purple
        V = "#c678dd",
        ["\22"] = "#c678dd",
        c = "#e5c07b",   -- yellow
        R = "#e06c75",   -- red
      }
      return { fg = mode_colors[vim.fn.mode()] or "#ffffff", bg = "none" }
    end,
    padding = { left = 0, right = 1 },
  },
},
        lualine_b = { 
          {
	    "branch",
	    color = { fg = "#8ebd6b" },
	  }
	},

        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          Snacks.profiler.status(),
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = function() return { fg = Snacks.util.color("Statement") } end,
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = function() return { fg = Snacks.util.color("Constant") } end,
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
	lualine_z = {{
          function()
            return "[" .. os.date("%T") .. "]"
          end,
	  color = { fg = "#a0a8b7" }
        }},
      },
      extensions = { "neo-tree", "lazy", "fzf" },
    }

    -- do not add trouble symbols if aerial is enabled
    -- And allow it to be overriden for some buffer types (see autocmds)
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
}
