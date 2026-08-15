local host = require("util.host")

return {
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "tokyonight",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "catppuccin-mocha",
      colorscheme = ({
        mbp = "tokyonight",
        ["rasppi4-1"] = "carbonfox",
      })[vim.fn.hostname()] or "tokyonight",
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
      },
      ensure_installed = {
        "nix", "rust", "ron", "kdl", "tmux"
      }
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        },
      },
      window = {
        mappings = {
          ["g/"] = "grep_at_current",
          ["gf"] = "find_at_current",
        },
      },
      commands = {
        grep_at_current = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local stat = vim.uv.fs_stat(path)
          if stat and stat.type == "file" then
            path = vim.fn.fnamemodify(path, ":h")
          end
          Snacks.picker.grep({ cwd = path })
        end,
        find_at_current = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          local stat = vim.uv.fs_stat(path)
          if stat and stat.type == "file" then
            path = vim.fn.fnamemodify(path, ":h")
          end
          Snacks.picker.files({ cwd = path })
        end,
      },
    },
  },
  {
    "nvim-orgmode/orgmode",
    -- init = function()
    --   require("orgmode").setup_ts_grammar()
    -- end,
    opts = {
      org_default_notes_file = "~/org/refile.org",
    },
    config = function()
      require("orgmode").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
        exclude = { "rust" },
      },
      servers = {
        copilot = { enabled = false },
        nil_ls = { enabled = false, mason = false },
        nixd = {
          mason = false,
          settings = {
            nixd = {
              formatting = {
                command = { "nixfmt" },
              },
              -- nix = {
              --   flake = {
              --     autoArchive = true,
              --     autoEvalInputs = false,
              --   },
              -- },
            },
          },
        },
        zls = {
          mason = false,
        },
      },
    },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            files = {
              excludeDirs = { ".direnv", ".cargo", "node_modules"},
            },
            check = {
              command = "clippy",
            },
          },
        },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    event = "VeryLazy",
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      -- require("fzf-lua").setup({
      --   "skim",
      --   fzf_bin = "sk",
      -- })
    end,
  },
  {
    "kkharji/xbase",
    enabled = host { "mbp" },
    ft = "swift",
    build = "make install",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim", -- optional
      "nvim-lua/plenary.nvim", -- optional/requirement of telescope.nvim
      "stevearc/dressing.nvim", -- optional (in case you don't use telescope but something else)
    },
    config = true,
    opts = {
      mappings = {
        enable = true,
        build_picker = "<leader>mb",
        run_picker = "<leader>mr",
        watch_picker = "<leader>mw",
        all_picker = "<leader>ma",
        toggle_split_log_buffer = "<leader>msl",
        toggle_vsplit_log_buffer = "<leader>mvl",
      },
    },
  },
  {
    "ziglang/zig.vim",
    enabled = false,
    ft = "zig",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_z = {
          function()
            return ">_"
          end,
        },
      },
    },
  },
}
