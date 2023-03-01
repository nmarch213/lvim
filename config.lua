--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "dracula"
vim.opt.relativenumber = true
vim.opt.guifont = "10"


-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"


-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- move line up and down
lvim.keys.normal_mode["<T-j>"] = ":m .+1<CR>=="
lvim.keys.normal_mode["<T-k>"] = ":m .-2<CR>=="

-- plugins
lvim.plugins = {
  { "Mofiqul/dracula.nvim" },
  { "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
          suggestion = {
            auto_trigger = true, -- Automatically trigger completion
            max_lines = 1000, -- Maximum number of lines to show
            min_lines = 1, -- Minimum number of lines to show

          }
        }
      end, 100)
    end,
  },

  { "zbirenbaum/copilot-cmp",
    after = { "copilot.lua", "nvim-cmp" },
  },
}

lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false


-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true



-- local linters = require "lvim.lsp.null-ls.linters"

-- linters.setup {
--   { command = "eslint", filetypes = { "typescript", "typescriptreact", "javascript" } }
-- }

local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact" }
  }
}

require("lvim.lsp.manager").setup "tailwindcss"
