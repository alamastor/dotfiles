local M = {}
local wk = require("which-key")
local prequire = require("user.common").prequire

local function remap(binding_fn_name)
  return string.format("<cmd>lua R('user.keymaps').bind('%s')<cr>", binding_fn_name)
end

M.bind = function(binding_fn_name)
  local filetype = vim.bo.filetype
  local module = prequire(string.format("user.ftmaps.%s", filetype))

  if module and module[binding_fn_name] then
    module[binding_fn_name]()
    return
  end

  local f = require("user.ftmaps.default")[binding_fn_name]
  if f then
    f()
  end
end

-- Remap space as leader key
-- Needs to be done before using leader in any maps!
vim.g.mapleader = " "

-- Reload this file
M.reload = function()
  R("user.keymaps")
  print("Keymaps reloaded.")
end
wk.add({
  { "<leader>r", group = "reload" },
  { "<leader>rr", "<cmd>lua require('user.keymaps').reload()<cr>", desc = "Reload Keymaps" },
})

-- NvimTree
wk.add({
  { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle Nvim Tree" },
})

-- DAP
wk.add({
  { "<leader>d", group = "dap" },
  { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "DAP step out" },
  { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "DAP toggle breakpoint" },
  { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "DAP continue" },
  { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "DAP step into" },
  { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "DAP run last" },
  { "<leader>dn", "<cmd>lua R('user.keymaps').bind('test_method')<cr>", desc = "DAP test method" },
  { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "DAP step over" },
  { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "DAP toggle REPL" },
  { "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", desc = "DAP terminate" },
  { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "DAP toggle UI" },
})

wk.add({
  { "K", "<cmd>lua R('user.keymaps').bind('documentation')<cr>", desc = "LSP docs" },
})

wk.add({
  { "g", group = "goto" },
  { "gD", "<cmd>lua R('user.keymaps').bind('go_to_declaration')<cr>", desc = "Goto declaration" },
  { "gd", "<cmd>lua R('user.keymaps').bind('go_to_definition')<cr>", desc = "Goto definition" },
  { "gi", "<cmd>lua R('user.keymaps').bind('implementation')<cr>", desc = "Goto implementation" },
  { "gl", "<cmd>lua R('user.keymaps').bind('diagnostic')<cr>", desc = "Goto diagnostics" },
  { "gr", "<cmd>lua R('user.keymaps').bind('references')<cr>", desc = "Goto references" },
})

wk.add({
  { "<leader>l", group = "lsp" },
  { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason" },
  { "<leader>la", "<cmd>lua R('user.keymaps').bind('code_action')<cr>", desc = "LSP code action" },
  { "<leader>le", group = "extract" },
  {
    "<leader>lec",
    "<cmd>lua R('user.keymaps').bind('extract_constant')<cr>",
    desc = "LSP extract constant",
  },
  {
    "<leader>lem",
    "<cmd>lua R('user.keymaps').bind('extract_method')<cr>",
    desc = "LSP extract method",
  },
  {
    "<leader>lev",
    "<cmd>lua R('user.keymaps').bind('extract_variable')<cr>",
    desc = "LSP extract variable",
  },
  { "<leader>lf", "<cmd>lua R('user.keymaps').bind('format_file')<cr>", desc = "LSP format file" },
  { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP info" },
  {
    "<leader>lj",
    "<cmd>lua R('user.keymaps').bind('next_diagnostic')<cr>",
    desc = "LSP next diagnostic",
  },
  {
    "<leader>lk",
    "<cmd>lua R('user.keymaps').bind('prev_diagnostic')<cr>",
    desc = "LSP prev diagnostic",
  },
  {
    "<leader>lo",
    "<cmd>lua R('user.keymaps').bind('organize_imports')<cr>",
    desc = "LSP organise imports",
  },
  { "<leader>lr", "<cmd>lua R('user.keymaps').bind('rename')<cr>", desc = "Rename" },
  {
    "<leader>ls",
    "<cmd>lua R('user.keymaps').bind('signature_help')<cr>",
    desc = "LSP signature help",
  },
})

-- Telescope
wk.add({
  { "<leader>f", group = "telescope" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
  { "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Telescope diagnostics" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Telescope files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Telescope grep" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Telescope help" },
  { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Telescope jumplist" },
  { "<leader>fr", "<cmd>Telescope resume<cr>", desc = "Telescope resume" },
  { "<leader>ft", group = "git" },
  { "<leader>ftf", "<cmd>Telescope git_files<cr>", desc = "Telescope Git files" },
})

-- Noice
wk.add({
  { "<leader>c", "<cmd>Noice dismiss<cr>", desc = "Noice dismiss" },
})

-- Git
local gs = require("gitsigns")
wk.add({
  { "<leader>h", group = "git" },
  {
    "<leader>hD",
    function()
      gs.diffthis("~")
    end,
    desc = "Git open diff with prev commit",
  },
  { "<leader>hR", ":Gitsigns reset_buffer<CR>", desc = "Git reset buffer" },
  { "<leader>hS", ":Gitsigns stage_buffer<CR>", desc = "Git stage buffer" },
  {
    "<leader>hb",
    function()
      gs.blame_line({ full = true })
    end,
    desc = "Git blame line",
  },
  { "<leader>hd", ":Gitsigns diffthis<CR>", desc = "Git open diff" },
  { "<leader>hp", ":Gitsigns preview_hunk<CR>", desc = "Git preview hunk" },
  { "<leader>ht", group = "Toggle" },
  { "<leader>htb", ":Gitsigns toggle_current_line_blame<CR>", desc = "Git toggle blame" },
  { "<leader>htd", ":Gitsigns toggle_deleted<CR>", desc = "Git toggle deleted" },
  { "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", desc = "Git undo stage hunk" },
  { "<leader>hr", ":Gitsigns reset_hunk<CR>", desc = "Git reset hunk", mode = { "n", "v" } },
  { "<leader>hs", ":Gitsigns stage_hunk<CR>", desc = "Git stage hunk", mode = { "n", "v" } },
})

-- Navigation
wk.add({
  { "]", group = "next" },
  {
    "]c",
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end,
    desc = "Next Git hunk",
  },
})

wk.add({
  { "[", group = "prev" },
  {
    "[c",
    function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end,
    desc = "Prev Git hunk",
  },
})

wk.add({
  { "<leader>t", group = "toggle" },
  { "<leader>tu", ":UndotreeToggle<CR>", desc = "Toggle Undotree" },
})

return M
