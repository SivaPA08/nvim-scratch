return {
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>d", "<cmd>Trouble buf_diagnostics toggle focus=true<cr>", desc = "Buffer Diagnostics" },
      { "<leader>D", "<cmd>Trouble diagnostics toggle focus=true<cr>",     desc = "Workspace Diagnostics" },
    },

    config = function()
      local w   = math.floor(vim.o.columns * 0.80)
      local h   = math.floor(vim.o.lines   * 0.60)
      local row = math.floor((vim.o.lines   - h) / 2)
      local col = math.floor((vim.o.columns - w) / 2)

      local function float_win(title)
        return {
          type     = "float",
          relative = "editor",
          border   = "rounded",
          width    = w,
          height   = h,
          row      = row,
          col      = col,
          wo = {
            winhighlight = "Normal:TroubleNormal,FloatBorder:TroubleBorder,CursorLine:TroubleSelected",
            cursorline   = true,
            number       = false,
            signcolumn   = "no",
            statuscolumn = "",
            winbar       = "",
          },
          title     = title,
          title_pos = "center",
        }
      end

      require("trouble").setup({
        modes = {
          diagnostics = {
            mode    = "diagnostics",
            focus   = true,
            win     = float_win("   Diagnostics  "),
            preview = { type = "main" },
            sort = {
              { key = "severity", order = "asc" },
              { key = "filename", order = "asc" },
              { key = "lnum",     order = "asc" },
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
            mode    = "diagnostics",
            focus   = true,
            filter  = { buf = 0 },
            win     = float_win("   Buffer Diagnostics  "),
            preview = { type = "main" },
            sort = {
              { key = "severity", order = "asc" },
              { key = "lnum",     order = "asc" },
            },
          },
        },

        icons = {
          indent = {
            top         = "│ ",
            middle      = "├╴",
            last        = "└╴",
            fold_open   = " ",
            fold_closed = " ",
            ws          = "  ",
          },
          folder_closed = " ",
          folder_open   = " ",
          kinds = {
            Array         = " ",
            Boolean       = "󰨙 ",
            Class         = " ",
            Constant      = "󰏿 ",
            Constructor   = " ",
            Enum          = " ",
            EnumMember    = " ",
            Event         = " ",
            Field         = " ",
            File          = " ",
            Function      = "󰊕 ",
            Interface     = " ",
            Key           = " ",
            Method        = "󰊕 ",
            Module        = " ",
            Namespace     = "󰦮 ",
            Null          = " ",
            Number        = "󰎠 ",
            Object        = " ",
            Operator      = " ",
            Package       = " ",
            Property      = " ",
            String        = " ",
            Struct        = "󰆼 ",
            TypeParameter = " ",
            Variable      = "󰀫 ",
          },
        },

        auto_close    = false,
        auto_preview  = false,
        follow_cursor = false,
      })

      -- Only override the background to terminal black; all fg/severity
      -- colours are inherited from your active colorscheme automatically.
      vim.api.nvim_set_hl(0, "TroubleNormal",   { bg = "#000000" })
      vim.api.nvim_set_hl(0, "TroubleNormalNC", { bg = "#000000" })
    end,
  },
}
