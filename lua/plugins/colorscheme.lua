return {
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("onedark").setup({ 
        style = "darker",
	transparent = true,
        ending_tildes = true,
          code_style = {
	    comments = 'none',
	    keywords = 'none',
	    functions = 'none',
	    strings = 'none',
	    variables = 'none'
	 },
      })
      require("onedark").load()
    end,
  },
}
