local opts = { noremap = true, silent = true }

vim.keymap.set("v", "<C-S-down>", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "<C-S-up>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("n", "<C-j>", ":cnext<CR>", opts)
vim.keymap.set("n", "<C-k>", ":cprevious<CR>", opts)
vim.keymap.set("n", "<Tab>", "<C-w>l", opts)
vim.keymap.set("n", "<S-Tab>", "<C-w>h", opts)
vim.keymap.set("n", "<leader>R", function()
	vim.ui.input({ prompt = "Command: " }, function(command)
		local dir = vim.fn.expand("%:p:h")
		if command then -- check for nil in case user cancels
			vim.cmd(string.format("!cd %s && %s", dir, command))
		end
	end)
end, opts)
vim.keymap.set("v", "<leader>R", function()
	vim.ui.input({ prompt = "Command: " }, function(command)
		local dir = vim.fn.expand("%:p:h")
		if command then -- check for nil in case user cancels
			vim.cmd(string.format("!cd %s && %s", dir, command))
		end
	end)
end, opts)
vim.keymap.set("n", "<leader>g", function()
  local dir = vim.fn.expand("%:p:h")
  local socket = "unix:/tmp/kitty-" .. (vim.env.KITTY_PID or "")

  if socket then
    local cmd = string.format('KITTY_LISTEN_ON=%s kitty @ launch --cwd="%s" --type=window lazygit 2> /dev/null', socket, dir)
    vim.cmd("silent !" .. cmd)
  else
    vim.notify("No Kitty socket found. Remote control not enabled in Kitty.", vim.log.levels.ERROR)
  end
end, { desc = "Open kitty split with neogit in buffer directory" })
