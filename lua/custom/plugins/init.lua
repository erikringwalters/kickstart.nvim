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
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      -- Import Kickstart’s defaults
      local on_attach = function(_, bufnr)
        -- Use Kickstart's mappings
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        nmap('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        nmap('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- Find references for the word under your cursor.
        nmap('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        nmap('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        nmap('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        nmap('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        nmap('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        nmap('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        nmap('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')
        -- Quick Fix/Code Action
        nmap('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')
      end
      -- Rust Analyzer setup
      lspconfig.rust_analyzer.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        -- cmd = { vim.fn.expand '~/.cargo/bin/rust-analyzer' },
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = false },
            procMacro = {
              ignored = {
                bevy_simple_subsecond_system_macros = {
                  'hot',
                },
              },
            },
            diagnostics = {
              enable = false,
              experimental = { enable = false },
              disabled = { 'proc-macro-disabled' },
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
          diagnostics = { refreshSupport = true },
        },
      }

      -- Make diagnostics update instantly (not only on save)
      vim.diagnostic.config {
        update_in_insert = true,
        virtual_text = true,
        signs = true,
        underline = true,
      }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT', -- Neovim uses LuaJIT
            },
            diagnostics = {
              globals = { 'vim' }, -- recognize `vim` as a global
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false, -- stop annoying "third party" prompt
            },
            telemetry = { enable = false },
          },
        },
      }
    end,
  },

  -- vim.keymap.set('n', '<leader>a', function()
  --   vim.lsp.buf.code_action()
  -- end, { desc = 'LSP Code [A]ction' }),

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
    },
  },
}
