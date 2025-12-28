vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = true
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.termguicolors = true
vim.o.signcolumn = "yes"

vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")

-- 设置剪贴板通用选项 (这行通常在所有平台都通用，可以放在外面)
vim.opt.clipboard = "unnamedplus"

-- 判断是否在 WSL 环境中
if vim.fn.getenv('WSL_DISTRO_NAME') ~= vim.v.null then
  -- WSL 专用配置：使用 win32yank.exe
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end