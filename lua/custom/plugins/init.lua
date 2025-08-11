-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- ***Erik's plugins*** --
  {
    'savq/melange-nvim',

    priority = 1000,
    config = function()
      vim.cmd 'colorscheme melange'
      vim.api.nvim_set_hl(0, 'Normal', { bg = '#161111' })
      vim.api.nvim_set_hl(0, 'String', { fg = '#886499' })
    end,
  },

  -- Easy Commenting
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
  },
}
