return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>d", "<cmd>Trouble buf_diagnostics toggle focus=true<cr>", desc = "Buffer Diagnostics" },
      { "<leader>D", "<cmd>Trouble diagnostics toggle focus=true<cr>", desc = "Workspace Diagnostics" },
    },

    config = function()
      local function right_split(width)
        return {
          type = "split",
          relative = "win",
          position = "right",
          size = width or 0.3,
        }
      end

      require("trouble").setup({
        modes = {
          diagnostics = {
            mode = "diagnostics",
            focus = true,
            win = right_split(0.30),
            preview = { type = "split", relative = "win", position = "right", size = 0.30 },
            sort = {
              { key = "severity", order = "asc" },
              { key = "filename", order = "asc" },
              { key = "lnum", order = "asc" },
            },
            filter = {
              severity = {
                vim.diagnostic.severity.ERROR,
                vim.diagnostic.severity.WARN,
                vim.diagnostic.severity.INFO,
                vim.diagnostic.severity.HINT,
              },
            },
          },

          buf_diagnostics = {
            mode = "diagnostics",
            focus = true,
            filter = { buf = 0 },
            win = right_split(0.30),
            preview = { type = "split", relative = "win", position = "right", size = 0.30 },
            sort = {
              { key = "severity", order = "asc" },
              { key = "lnum", order = "asc" },
            },
          },
        },

        auto_close = false,
        auto_preview = false,
        follow_cursor = false,
      })
    end,
  },
}
