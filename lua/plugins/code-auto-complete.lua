return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    opts = {
      keymaps = {
        accept_suggestion = "<C-s>",
        clear_suggestion = "<C-]>",
        accept_word = "<C-j>",
      },
      disable_inline_completion = false,
      disable_keymaps = false,
      ignore_filetypes = {
        bigfile = true,
      },
    },
  },
}
