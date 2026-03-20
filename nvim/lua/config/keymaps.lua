local keymap = vim.keymap

keymap.set("n", "<leader>w", ":w<CR>")
keymap.set("n", "<leader>q", ":q<CR>")

-- Navegação entre splits
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
