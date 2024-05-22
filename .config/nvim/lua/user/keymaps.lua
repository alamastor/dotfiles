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
wk.register({
  ["<leader>r"] = {
    name = "+reload",
    r = { "<cmd>lua require('user.keymaps').reload()<cr>", "Reload Keymaps" },
  },
})

-- NvimTree
wk.register({ ["<leader>e"] = { ":NvimTreeToggle<CR>", "Toggle Nvim Tree" } })

-- DAP
wk.register({
  ["<leader>d"] = {
    name = "+dap",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "DAP toggle breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "DAP continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "DAP step into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "DAP step over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "DAP step out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "DAP toggle REPL" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "DAP run last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "DAP toggle UI" },
    t = { "<cmd>lua require'dap'.terminate()<cr>", "DAP terminate" },
    n = { remap("test_method"), "DAP test method" },
  },
})

wk.register({ K = { remap("documentation"), "LSP docs" } })

wk.register({
  g = {
    name = "+goto",
    D = { remap("go_to_declaration"), "Goto declaration" },
    d = { remap("go_to_definition"), "Goto definition" },
    i = { remap("implementation"), "Goto implementation" },
    r = { remap("references"), "Goto references" },
    l = { remap("diagnostic"), "Goto diagnostics" },
  },
})

wk.register({
  ["<leader>l"] = {
    name = "+lsp",
    f = { remap("format_file"), "LSP format file" },
    a = { remap("code_action"), "LSP code action" },
    j = { remap("next_diagnostic"), "LSP next diagnostic" },
    k = { remap("prev_diagnostic"), "LSP prev diagnostic" },
    r = { remap("rename"), "Rename" },
    s = { remap("signature_help"), "LSP signature help" },
    o = { remap("organize_imports"), "LSP organise imports" },
    e = {
      name = "+extract",
      v = { remap("extract_variable"), "LSP extract variable" },
      c = { remap("extract_constant"), "LSP extract constant" },
      m = { remap("extract_method"), "LSP extract method" },
    },
    i = { "<cmd>LspInfo<cr>", "LSP info" },
    I = { "<cmd>Mason<cr>", "Mason" },
  },
})

-- Telescope
wk.register({
  ["<leader>f"] = {
    name = "+telescope",
    b = { "<cmd>Telescope buffers<cr>", "Telescope buffers" },
    g = { "<cmd>Telescope live_grep<cr>", "Telescope grep" },
    h = { "<cmd>Telescope help_tags<cr>", "Telescope help" },
    f = { "<cmd>Telescope find_files<cr>", "Telescope files" },
    d = { "<cmd>Telescope diagnostics<cr>", "Telescope diagnostics" },
    r = { "<cmd>Telescope resume<cr>", "Telescope resume" },
    j = { "<cmd>Telescope jumplist<cr>", "Telescope jumplist" },
    t = { name = "+git", f = { "<cmd>Telescope git_files<cr>", "Telescope Git files" } },
  },
})

-- Noice
wk.register({ ["<leader>c"] = { "<cmd>Noice dismiss<cr>", "Noice dismiss" } })

-- Git
local gs = require("gitsigns")
wk.register({
  ["<leader>h"] = {
    name = "+git",
    S = { ":Gitsigns stage_buffer<CR>", "Git stage buffer" },
    u = { ":Gitsigns undo_stage_hunk<CR>", "Git undo stage hunk" },
    R = { ":Gitsigns reset_buffer<CR>", "Git reset buffer" },
    p = { ":Gitsigns preview_hunk<CR>", "Git preview hunk" },
    b = {
      function()
        gs.blame_line({ full = true })
      end,
      "Git blame line",
    },
    d = { ":Gitsigns diffthis<CR>", "Git open diff" },
    D = {
      function()
        gs.diffthis("~")
      end,
      "Git open dif with prev commit",
    },
    t = {
      name = "Toggle",
      b = { ":Gitsigns toggle_current_line_blame<CR>", "Git toggle blame" },
      d = { ":Gitsigns toggle_deleted<CR>", "Git toggle deleted" },
    },
  },
  s = { ":Gitsigns stage_hunk<CR>", "Git stage hunk", mode = { "v", "n" } },
  r = { ":Gitsigns reset_hunk<CR>", "Git reset hunk", mode = { "v", "n" } },
})

-- Navigation
wk.register({
  ["]"] = {
    name = "+next",
    c = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end,
      "Next Git hunk",
    },
  },
})

wk.register({
  ["["] = {
    name = "+prev",
    c = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Prev Git hunk",
    },
  },
})

wk.register({
  ["<leader>t"] = { name = "+toggle", u = { ":UndotreeToggle<CR>", "Toggle Undotree" } },
})

return M
