-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- ***Erik's plugins*** --
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function(_, opts)
      require('ibl').setup(opts)
      -- now override highlight
      vim.schedule(function()
        vim.api.nvim_set_hl(0, '@ibl.scope.underline.1', { underline = false })
      end)
    end,
  },

  -- Melange theme with custom colors
  {
    'savq/melange-nvim',

    priority = 1000,
    config = function()
      vim.cmd 'colorscheme melange'
      vim.api.nvim_set_hl(0, 'Normal', { bg = '#0E0B0B' })
      vim.api.nvim_set_hl(0, 'String', { fg = '#7E6B96' })
      vim.api.nvim_set_hl(0, '@ibl.scope.underline.1', { underline = false })
      local bg = vim.opt.background:get()
      local palette = require('melange/palettes/' .. bg)
      vim.g.terminal_color_9 = palette.b.bg
    end,
  },

  -- Easy Commenting (use commands gc or gcc)
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },

  -- LSP config
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      -- Rust Analyzer setup
      lspconfig.rust_analyzer.setup {
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            diagnostics = {
              enable = true,
              experimental = { enable = true },
            },
            checkOnSave = {
              enable = true,
              command = 'clippy',
            },
            assist = {
              importGranularity = 'module',
              importPrefix = 'by_self',
            },
            imports = {
              granularity = { group = 'module' },
              prefix = 'self',
            },
            completion = {
              autoimport = { enable = true },
              postfix = { enable = true },
            },
          },
        },
        flags = {
          allow_incremental_sync = true,
          diagnostics = { refreshSupport = false },
        },
      }

      -- Make diagnostics update instantly (not only on save)
      vim.diagnostic.config {
        update_in_insert = true,
        virtual_text = true,
        signs = true,
        underline = true,
      }
    end,
  },

  -- -- Optional: Mason to install rust-analyzer automatically
  -- {
  --   'williamboman/mason.nvim',
  --   build = ':MasonUpdate',
  --   config = function()
  --     require('mason').setup()
  --   end,
  -- },
  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   config = function()
  --     require('mason-lspconfig').setup {
  --       ensure_installed = { 'rust_analyzer' },
  --     }
  --   end,
  -- },

  vim.keymap.set('n', '<leader>qf', function()
    vim.lsp.buf.code_action()
  end, { desc = 'LSP [Q]uick [F]ix' }),
}
