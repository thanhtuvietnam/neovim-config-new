local opt = vim.opt

opt.title = true
opt.autoindent = true
opt.smartindent = true
opt.hlsearch = true
opt.backup = false
opt.showcmd = true
opt.cmdheight = 1
opt.laststatus = 3
opt.expandtab = true
opt.scrolloff = 10
opt.shell = "/bin/zsh"
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.inccommand = "split"
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.smarttab = true
opt.breakindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.wrap = true
-- opt.wrap = false -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*" })
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "cursor"
opt.relativenumber = false

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- Terminal
vim.cmd([[  
  autocmd TermOpen * setlocal winblend=20  
  " autocmd TermOpen * setlocal winhighlight=Normal:NormalNC  
]])

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.cmd([[au BufNewFile,BufRead *.astro setf astro]])
vim.cmd([[au BufNewFile,BufRead Podfile setf ruby]])

if vim.fn.has("nvim-0.8") == 1 then
  vim.opt.cmdheight = 0
end

--highlight group formatoptions LSP

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#9CDCFE", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#9CDCFE", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C586C0", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#C586C0", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#D4D4D4", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#D4D4D4", bg = "NONE" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#D4D4D4", bg = "NONE" })

--diagnostic

-- vim.o.completeopt = "menuone,noinsert,noselect"
--
-- vim.lsp.inlay_hint.enable()
--
-- vim.diagnostic.config({
--   virtual_text = false,
--   float = { border = "rounded" },
-- })

vim.o.updatetime = 250
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
-- vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335 guifg=#abb2bf]])
--Lazy.nvim
