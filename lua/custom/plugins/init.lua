-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- ***Erik's plugins*** --

  -- Melange theme with custom colors
  {
    'savq/melange-nvim',

    priority = 1000,
    config = function()
      vim.cmd 'colorscheme melange'
      vim.api.nvim_set_hl(0, 'Normal', { bg = '#080606' })
      vim.api.nvim_set_hl(0, 'String', { fg = '#7E6B96' })
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

  -- Rust configs
  -- {
  --   'rust-lang/rust-analyzer',
  -- },
  -- {
  --   'rust-lang/rust.vim',
  --   ft = 'rust',
  --   init = function()
  --     vim.g.rustfmt_autosave = 1
  --   end,
  -- },
  -- {
  --   'saecki/crates.nvim',
  --   ft = { 'toml' },
  --   config = function(_, opts)
  --     local crates = require 'crates'
  --     crates.setup(opts)
  --     require('cmp').setup.buffer {
  --       sources = { { name = 'crates' } },
  --     }
  --     crates.show()
  --     require('core.utils').load_mappings 'crates'
  --   end,
  -- },
  -- {
  --   'theHamsta/nvim-dap-virtual-text',
  --   lazy = false,
  --   config = function(_, opts)
  --     require 'nvim-dap-virtual-text'
  --   end,
  -- },
  -- {
  --   'mfussenegger/nvim-dap',
  -- },
  -- {
  --   'rcarriga/nvim-dap-ui',
  --   dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  --   config = function()
  --     require('dapui').setup()
  --   end,
  -- },
  -- {
  --   'mfussenegger/nvim-dap',
  --   config = function()
  --     local dap, dapui = require 'dap', require 'dapui'
  --     dap.listeners.before.attach.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       dapui.close()
  --     end
  --   end,
  -- },
  -- {
  --   'rcarriga/nvim-dap-ui',
  --   dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
  --   config = function()
  --     require('dapui').setup()
  --   end,
  -- },
  -- {
  --   'vadimcn/codelldb',
  -- },
  -- {
  --   'hrsh7th/nvim-cmp',
  -- },
  -- {
  --   'hrsh7th/cmp-nvim-lsp',
  -- },
  -- { 'hrsh7th/cmp-nvim-lua' },
  -- { 'hrsh7th/cmp-nvim-lsp-signature-help' },
  -- { 'hrsh7th/cmp-vsnip' },
  -- { 'hrsh7th/cmp-path' },
  -- { 'hrsh7th/cmp-buffer' },
  -- { 'hrsh7th/vim-vsnip' },
}
