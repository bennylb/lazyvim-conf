return {
  {
    "ChmaraX/herdr-nvim",
    opts = {},
    config = function(_, opts)
      local hn = require("herdr-nvim")
      hn.setup(opts)
      -- herdr's sidebar daemon always calls setup() again on VimEnter; disable
      -- keymap install so that second call does not warn about maps we just set.
      hn.config.keymaps = false
    end,
  },
}
