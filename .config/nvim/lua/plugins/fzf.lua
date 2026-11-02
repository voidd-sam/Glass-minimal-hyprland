return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      "telescope",

      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          default = "bat",
          horizontal = "right:60%",
        },
      },

      files = {
        cmd = "fd --type f --hidden --exclude .git --exclude node_modules",
        cwd_prompt = false,
      },

      grep = {
        rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -g '!.git' -g '!node_modules'",
      },
    })
  end,
}
