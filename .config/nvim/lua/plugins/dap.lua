return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python",
    "nvim-neotest/nvim-nio",
    "folke/neodev.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("neodev").setup({
      library = { plugins = { "nvim-dap-ui" }, types = true },
    })

    dapui.setup({
      expand_lines = true,
      icons = { expanded = "", collapsed = "", circular = "" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 0.33,
          position = "right",
        },
        {
          elements = {
            { id = "repl", size = 0.45 },
            { id = "console", size = 0.55 },
          },
          size = 0.27,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5, -- Floats will be treated as percentage of your screen.
        border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" }
    )

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Python
    local dap_python = require("dap-python")
    dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")
    local python_configs = require("dap").configurations.python
    for _, config in ipairs(python_configs) do
      config.justMyCode = false
    end

    -- Used by the search simulator debug config. Global, so it can be
    -- called from the completion function
    ---@diagnostic disable-next-line: lowercase-global
    search_runs = function()
      local runs = {}
      for _, path_str in ipairs(vim.fn.split(vim.fn.glob("local_results/**/settings.json"), "\n")) do
        if string.sub(path_str, 1, 24) ~= "local_results/artifacts/" then
          table.insert(runs, string.sub(path_str, 15, -15))
        end
      end
      return runs
    end

    table.insert(python_configs, {
      name = "Search Simulator",
      type = "python",
      module = "pipelines.simulation.run_pipeline",
      args = function()
        local run = vim.fn.input({
          prompt = "Run: ",
          completion = "customlist,v:lua.search_runs",
        })
        return { "--pipeline-dir", "local_results", "--run", run }
      end,
      request = "launch",
      justMyCode = false,
    })
    dap_python.test_runner = "pytest"
    require("user.common").ensure_mason_installed("debugpy")
  end,
}
