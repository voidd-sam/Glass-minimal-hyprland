return {
  -- add pywal16.nvim
  {
    "uZer/pywal16.nvim",
    lazy = false,
    priority = 1000, -- load before other plugins
  },

  -- tell LazyVim to use it as the colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "pywal16",
    },
  },
}
