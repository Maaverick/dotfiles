return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
      untracked    = { text = "┆" },
    },
    signs_staged = {
      add          = { text = "│" },
      change       = { text = "│" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    },
    signcolumn = true, -- Keep the signcolumn enabled
    numhl = false,     -- Don't highlight line numbers
    linehl = false,    -- Don't highlight entire lines
    word_diff = false,
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Always show inline blame
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol",
      delay = 1000,
    },
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- Optional: Key mappings for git operations
    vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
    vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
    vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", { desc = "Stage buffer" })
    vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", { desc = "Undo stage hunk" })
    vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", { desc = "Reset buffer" })
    vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
    vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
    vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", { desc = "Diff this" })
    vim.keymap.set("n", "<leader>hD", "<cmd>Gitsigns diffthis~<CR>", { desc = "Diff this ~" })
    vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<CR>", { desc = "Next hunk" })
    vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Prev hunk" })
  end,
}
