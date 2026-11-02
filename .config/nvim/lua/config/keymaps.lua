-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.g.mapleader = " "
-- Select all and copy to system clipboard in one press
vim.keymap.set("n", "<leader>a", "ggVG", { desc = "select all" })

local fzf = require("fzf-lua")

vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "[F]ind by [G]rep" })
vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "[F]ind [B]uffers" })
vim.keymap.set("n", "<leader>fr", fzf.oldfiles, { desc = "[F]ind [R]ecent" })
vim.keymap.set("n", "<leader>f.", fzf.resume, { desc = "Resume last picker" })
vim.keymap.set("n", "<leader>fw", fzf.grep_cword, { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>gc", fzf.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gs", fzf.git_status, { desc = "Git status" })
vim.keymap.set("n", "<leader>fs", fzf.lsp_document_symbols, { desc = "LSP symbols" })
vim.keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", { desc = "New tab" })
