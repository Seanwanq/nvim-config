-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if LazyVim.is_win() then
  LazyVim.terminal.setup("pwsh")
end

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
end
