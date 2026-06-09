return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "main", -- auto, main, moon, or dawn
        dark_variant = "main",
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        styles = {
          bold = false,
          italic = false,
          transparency = true,
        },

        highlight_groups = {
          -- Transparent backgrounds
          Normal = { bg = "NONE" },
          NormalFloat = { bg = "NONE" },
          NormalNC = { bg = "NONE" },
          SignColumn = { bg = "NONE" },
          EndOfBuffer = { bg = "NONE" },
          FloatBorder = { bg = "NONE" },
          CursorLine = { bg = "NONE" },

          -- Gentle base highlights with minimal contrast
          Comment = { fg = "muted" },
          LineNr = { fg = "muted" },
          CursorLineNr = { fg = "subtle" },

          -- Soft, harmonious syntax colors
          String = { fg = "pine" },
          Function = { fg = "foam" },
          Keyword = { fg = "iris" },
          Type = { fg = "gold" },
          Constant = { fg = "rose" },
          Operator = { fg = "#ffffff" }, -- White operators

          -- Treesitter highlights
          ["@string"] = { fg = "pine" },
          ["@function"] = { fg = "foam" },
          ["@function.builtin"] = { fg = "foam" },
          ["@function.method"] = { fg = "foam" },
          ["@keyword"] = { fg = "iris" },
          ["@keyword.function"] = { fg = "iris" },
          ["@keyword.return"] = { fg = "iris" },
          ["@type"] = { fg = "gold" },
          ["@type.builtin"] = { fg = "foam" },
          ["@constant"] = { fg = "rose" },
          ["@constant.builtin"] = { fg = "rose" },
          ["@operator"] = { fg = "#ffffff" }, -- White operators
          ["@variable"] = { fg = "text" },
          ["@variable.builtin"] = { fg = "love" },
          ["@parameter"] = { fg = "gold" },
          ["@property"] = { fg = "pine" },
          ["@punctuation.bracket"] = { fg = "#ffffff" }, -- White brackets
          ["@punctuation.delimiter"] = { fg = "#ffffff" }, -- White delimiters
          ["@punctuation.special"] = { fg = "#ffffff" }, -- White special punctuation

          -- UI elements with softer contrast
          Visual = { bg = "#524f67", fg = "NONE" },
          -- Visual = { bg = "highlight_low" },
          Search = { bg = "highlight_med", fg = "gold" },
          IncSearch = { bg = "highlight_high", fg = "rose" },
          Pmenu = { bg = "NONE", fg = "text" },
          PmenuSel = { bg = "highlight_low", fg = "foam" },
        },
      })

      vim.cmd.colorscheme("rose-pine")

      -- Ensure transparency is applied
      vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    end,
  },
}
