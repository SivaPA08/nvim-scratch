return {
  -- nvim-cmp: completion engine
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip")

      -- Make the completion and documentation windows bordered
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(vim.tbl_extend("force", border_opts, {
            max_width = 80,
            max_height = 20,
          })),
        },

        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer", keyword_length = 3 },
        }),

        -- lspkind formatting: icons + kind label + source tag (matches screenshot)
        formatting = {
          expandable_indicator = true,
          fields = { "abbr", "kind", "menu" },
          format = lspkind.cmp_format({
            mode = "symbol_text",   -- show icon AND text (e.g. " boolean")
            maxwidth = 50,
            ellipsis_char = "...",
            show_labelDetails = true,

            -- Right-align the source name in square brackets like the screenshot
            before = function(entry, vim_item)
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snip]",
                buffer   = "[Buf]",
                path     = "[Path]",
              })[entry.source.name]
              return vim_item
            end,
          }),
        },

        -- Always open documentation float immediately
        experimental = {
          ghost_text = true,
        },

        -- Force documentation to appear without delay
        view = {
          docs = {
            auto_open = true,
          },
        },
      })

      -- Tell LSP servers to send back full detail / labelDetails in completions
      -- (put this in your lspconfig setup too, but having it here ensures cmp requests it)
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion.completionItem = vim.tbl_deep_extend("force",
        capabilities.textDocument.completion.completionItem or {}, {
          documentationFormat   = { "markdown", "plaintext" },
          snippetSupport        = true,
          preselectSupport      = true,
          insertReplaceSupport  = true,
          labelDetailsSupport   = true,
          deprecatedSupport     = true,
          commitCharactersSupport = true,
          tagSupport            = { valueSet = { 1 } },
          resolveSupport        = {
            properties = { "documentation", "detail", "additionalTextEdits" },
          },
        }
      )

      -- Cmdline completion for "/"
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      -- Cmdline completion for ":"
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources(
          { { name = "path" } },
          { { name = "cmdline" } }
        ),
      })

      -- ── Highlight tweaks to match the screenshot ──────────────────────────
      -- Dark background for the popup, subtle border, cyan for selected item
      vim.api.nvim_set_hl(0, "CmpPmenu",       { bg = "#1a1a2e" })
      vim.api.nvim_set_hl(0, "CmpPmenuBorder", { fg = "#44475a" })
      vim.api.nvim_set_hl(0, "PmenuSel",       { bg = "#2d4f67", fg = "NONE", bold = true })

      -- Kind colours (matches the teal/cyan palette in your screenshot)
      vim.api.nvim_set_hl(0, "CmpItemKindText",          { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "CmpItemKindMethod",        { fg = "#7dcfff" })
      vim.api.nvim_set_hl(0, "CmpItemKindFunction",      { fg = "#7dcfff" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstructor",   { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "CmpItemKindField",         { fg = "#73daca" })
      vim.api.nvim_set_hl(0, "CmpItemKindVariable",      { fg = "#bb9af7" })
      vim.api.nvim_set_hl(0, "CmpItemKindClass",         { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "CmpItemKindInterface",     { fg = "#73daca" })
      vim.api.nvim_set_hl(0, "CmpItemKindModule",        { fg = "#7dcfff" })
      vim.api.nvim_set_hl(0, "CmpItemKindProperty",      { fg = "#73daca" })
      vim.api.nvim_set_hl(0, "CmpItemKindUnit",          { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "CmpItemKindValue",         { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnum",          { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "CmpItemKindKeyword",       { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "CmpItemKindSnippet",       { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "CmpItemKindColor",         { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "CmpItemKindFile",          { fg = "#c0caf5" })
      vim.api.nvim_set_hl(0, "CmpItemKindReference",     { fg = "#c0caf5" })
      vim.api.nvim_set_hl(0, "CmpItemKindFolder",        { fg = "#7dcfff" })
      vim.api.nvim_set_hl(0, "CmpItemKindEnumMember",    { fg = "#9ece6a" })
      vim.api.nvim_set_hl(0, "CmpItemKindConstant",      { fg = "#e0af68" })
      vim.api.nvim_set_hl(0, "CmpItemKindStruct",        { fg = "#ff9e64" })
      vim.api.nvim_set_hl(0, "CmpItemKindEvent",         { fg = "#f7768e" })
      vim.api.nvim_set_hl(0, "CmpItemKindOperator",      { fg = "#c0caf5" })
      vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter", { fg = "#73daca" })
    end,
  },
}
