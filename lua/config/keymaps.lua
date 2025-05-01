vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Spilt vertically" } )
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Spilt horizontally" } )

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "No highlights" })



