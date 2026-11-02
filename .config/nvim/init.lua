-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.keymaps")
vim.opt.mouse = "a"

local function my_syntax_colors()
  local hl = vim.api.nvim_set_hl

  -- Catppuccin Mocha palette
  local rosewater = "#f5e0dc"
  local flamingo = "#f2cdcd"
  local pink = "#f5c2e7"
  local mauve = "#cba6f7"
  local red = "#f38ba8"
  local maroon = "#eba0ac"
  local peach = "#fab387"
  local yellow = "#f9e2af"
  local green = "#a6e3a1"
  local teal = "#94e2d5"
  local sky = "#89dceb"
  local sapphire = "#74c7ec"
  local blue = "#89b4fa"
  local lavender = "#b4befe"
  local text = "#cdd6f4"
  local subtext0 = "#a6adc8"
  local overlay0 = "#6c7086"

  -- Legacy groups
  hl(0, "Comment", { fg = overlay0, italic = true })
  hl(0, "String", { fg = green })
  hl(0, "Keyword", { fg = mauve, bold = true })
  hl(0, "Function", { fg = blue })
  hl(0, "Type", { fg = yellow })
  hl(0, "Number", { fg = peach })
  hl(0, "Boolean", { fg = peach })
  hl(0, "Constant", { fg = peach })
  hl(0, "Operator", { fg = sky })
  hl(0, "Conditional", { fg = mauve })
  hl(0, "Repeat", { fg = mauve })
  hl(0, "Identifier", { fg = red })
  hl(0, "PreProc", { fg = mauve })
  hl(0, "Special", { fg = pink })

  -- Treesitter groups
  hl(0, "@comment", { fg = overlay0, italic = true })
  hl(0, "@string", { fg = green })
  hl(0, "@keyword", { fg = mauve, bold = true })
  hl(0, "@keyword.function", { fg = mauve })
  hl(0, "@keyword.return", { fg = mauve })
  hl(0, "@function", { fg = blue })
  hl(0, "@function.call", { fg = blue })
  hl(0, "@function.builtin", { fg = sapphire })
  hl(0, "@type", { fg = yellow })
  hl(0, "@type.builtin", { fg = yellow })
  hl(0, "@number", { fg = peach })
  hl(0, "@boolean", { fg = peach })
  hl(0, "@constant", { fg = peach })
  hl(0, "@constant.builtin", { fg = peach })
  hl(0, "@variable", { fg = text })
  hl(0, "@variable.parameter", { fg = maroon })
  hl(0, "@variable.builtin", { fg = red })
  hl(0, "@property", { fg = lavender })
  hl(0, "@field", { fg = lavender })
  hl(0, "@operator", { fg = sky })
  hl(0, "@punctuation.bracket", { fg = subtext0 })
  hl(0, "@punctuation.delimiter", { fg = subtext0 })
  hl(0, "@tag", { fg = mauve })
  hl(0, "@tag.attribute", { fg = yellow })
  hl(0, "@module", { fg = yellow })
  hl(0, "@string.special", { fg = pink })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = my_syntax_colors,
})

my_syntax_colors()
