return {
  format_file = function()
    -- Guard will fall back to LSP is no formatter is configured
    vim.cmd('GuardFmt')
  end,
  go_to_declaration = function()
    vim.cmd('lua vim.lsp.buf.declaration()')
  end,
  go_to_definition = function()
    vim.cmd('lua vim.lsp.buf.definition()')
  end,
  documentation = function()
    vim.cmd('lua vim.lsp.buf.hover()')
  end,
  go_to_implementation = function()
    vim.cmd('lua vim.lsp.buf.implementation()')
  end,
  references = function()
    vim.cmd('lua vim.lsp.buf.references()')
  end,
  diagnostic = function()
    vim.cmd('lua vim.diagnostic.open_float()')
  end,
  code_action = function()
    vim.cmd('lua vim.lsp.buf.code_action()')
  end,
  next_diagnostic = function()
    vim.cmd('lua vim.diagnostic.goto_next({buffer=0})')
  end,
  prev_diagnostic = function()
    vim.cmd('lua vim.diagnostic.goto_prev({buffer=0})')
  end,
  rename = function()
    vim.cmd('lua vim.lsp.buf.rename()')
  end,
  signature_help = function()
    vim.cmd('lua vim.lsp.buf.signature_help()')
  end,
}
