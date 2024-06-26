local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local filename = {
  "filename",
  path = 1,
  color = function()
    local colors = require("colorbuddy").colors
    return { fg = vim.bo.modified and colors.purple:to_rgb() or colors.white:to_rgb() }
  end,
}

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { "alpha", "dashboard" },
      always_divide_middle = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },
      lualine_c = { diagnostics },
      lualine_x = {
        diff,
        spaces,
        "encoding",
        filetype,
        filename,
        require("recorder").displaySlots,
        require("recorder").recordingStatus,
      },
      lualine_y = { location },
      lualine_z = { "progress" },
    },
  },
}
