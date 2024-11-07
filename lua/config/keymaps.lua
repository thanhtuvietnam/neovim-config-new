local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

--Do things without affecting the register
keymap("n", "x", '"_x', opts)
local leader_mappings = {
  p = '"0p',
  P = '"0P',
  c = '"_c',
  C = '"_C',
  d = '"_d',
  D = '"_D',
}
for key, cmd in pairs(leader_mappings) do
  keymap({ "n", "v" }, "<Leader>" .. key, cmd, opts)
end

--Increment/decrement
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")

--Delete a word backwards
-- keymap.set("n", "dw", "vb_d")
keymap("n", "<C-a>", "gg<S-v>G")

--Jumplist
keymap("n", "<C-m>", "<C-i>", opts)

--New Tab
keymap("n", "<Leader>te", ":tabedit<CR>", opts)
keymap("n", "<Tab>", ":tabnext<CR>", opts)
keymap("n", "<S-Tab>", ":tabprev<CR>", opts)

--Split window
keymap("n", "ss", ":split<CR>", opts)
keymap("n", "sv", ":vsplit<CR>", opts)

-- Move window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize window
keymap("n", "<C-w><Left>", "<C-w><", opts)
keymap("n", "<C-w><Right>", "<C-w>>", opts)
keymap("n", "<C-w><Up>", "<C-w>+", opts)
keymap("n", "<C-w><Down>", "<C-w>-", opts)


-- Diagnostics
keymap("n", "<C-p>", function()
  vim.diagnostic.goto_next()
end, opts)
