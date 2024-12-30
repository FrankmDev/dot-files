return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<C-g>",
          next_suggestion = "<C-f>",
          accept_current_suggestion = "<C-M>",
          clear_suggestion = "<C-x>",
        },
      })
    end,
  },
}
