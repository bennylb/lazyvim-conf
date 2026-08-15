local host = require("util.host")

return {
{
    "folke/sidekick.nvim",
    enabled = host { "mbp", "rasppi4-1", },
    opts = {
      nes = { enabled = false },
      -- copilot = { status = { enabled = false } },
      cli = {
        mux = {
          enabled = false,
          backend = "tmux",
        },
        tools = {
          codex = {
            format = function(text)
              local Text = require("sidekick.text")
              text = vim.deepcopy(text)

              Text.transform(text, function(str)
                return str == "@" and "" or str
              end, "SidekickLocDelim")

              return Text.to_string(text)
            end,
          },
          -- https://github.com/folke/sidekick.nvim#how-do-i-add-my-own-ai-tool
          omp = {
            cmd = { "omp" },
            is_proc = "\\<omp\\>",
            url = "https://github.com/can1357/oh-my-pi",
            resume = { "--resume" },
            continue = { "--continue" },
          },
          kimi = {
            cmd = { "kimi" },
            is_proc = "\\<kimi\\>",
            url = "https://github.com/MoonshotAI/kimi-code",
            resume = { "--session" },
            continue = { "--continue" },
          },
        },
        win = {
          layout = "right",
          -- default split width is 80; make it wider
          width = 200,
          keys = {
            buffers = { "<c-b>", "buffers", mode = "n", desc = "open buffer picker" },
            files = { "<c-f>", "files", mode = "n", desc = "open file picker" },
            prompt = { "<c-s-p>", "prompt", mode = "t", desc = "insert prompt or context" },
            -- Buffer-local only (ft=sidekick_terminal): override LazyVim's global <C-/>
            -- terminal toggle and forward the traditional Ctrl-_ byte that Codex expects.
            send_ctrl_slash = {
              "<C-/>",
              function(t)
                if t.job then
                  vim.fn.chansend(t.job, "\x1f")
                end
              end,
              mode = "t",
              desc = "Send Ctrl-/ to CLI",
            },
            send_ctrl_underscore = {
              "<C-_>",
              function(t)
                if t.job then
                  vim.fn.chansend(t.job, "\x1f")
                end
              end,
              mode = "t",
              desc = "Send Ctrl-_ to CLI",
            },
          },
        },
      },
    },
    keys = {
      -- {
      --   "<leader>ax",
      --   function() require("sidekick.cli").toggle({ name = "codex", focus = true }) end,
      --   desc = "Sidekick Codex Toggle",
      --   mode = { "n", "v" },
      -- },
      -- {
      --   "<leader>ac",
      --   function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
      --   desc = "Sidekick Claude Toggle",
      --   mode = { "n", "v" },
      -- },
      -- {
      --   "<leader>ao",
      --   function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
      --   desc = "Sidekick Opencode Toggle",
      --   mode = { "n", "v" },
      -- },
    },
  },

}
