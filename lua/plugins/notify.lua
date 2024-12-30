return {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        background_colour = "#000000",
        stages = "fade",
        render = "minimal",
        timeout = "1000",
        fps = 144,
        top_down = false,
      })
    end,
  },
}
