{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # LSP Servers
    extraPackages = with pkgs; [
	    nixd					                          # Nix
	    pyright					                        # Python
	    rust-analyzer				                    # Rust
	    nodePackages.typescript-language-server	# JS/TS
	    vscode-langservers-extracted		        # HTML/CSS/JSON/ESLint
	    texlab					                        # LaTeX
    ];

    plugins = with pkgs.vimPlugins; [
      # Theme
      rose-pine

      # Syntax highlighting
      nvim-treesitter.withAllGrammars

      # Autocomplete engine and its sources
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
      cmp_luasnip

      # TabLine
      bufferline-nvim
      nvim-web-devicons

      # LSP
      nvim-lspconfig

      # Mini-map
      codewindow-nvim
    ];

    extraLuaConfig = ''
      -- Explorador de archivos
      vim.g.netrw_banner = 0
      vim.g.netrw_liststyle = 3
      vim.keymap.set('n', '<C-b>', ':Lexplore<CR>', { silent = true })

      -- Terminal
      vim.keymap.set('n', '<C-t>', ':split | terminal<CR>i', { silent = true })

      -- bufferline
      vim.keymap.set('n', '<Tab>', ':bnext<CR>', { silent = true })
      vim.keymap.set('n', '<S-Tab>', ':bprev<CR>', { silent = true })
      vim.keymap.set('n', '<C-q>', ':bd<CR>', { silent = true})

      -- Tabline
      require("bufferline").setup({
        options = {
          mode = "buffers",
          separator_style = "thin",
          always_show_bufferline = true,
          show_buffer_close_icons = true,
          show_close_icon = true,
          offsets = {
            {
              filetype = "netrw",
              text = "File Explorer",
              text_align = "left",
              separator = true
            }
          }
        }
      })

      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.softtabstop = 2 

      -- Show buffers
      vim.opt.showtabline = 2

      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*",
        command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif"
      })

      -- Color Theme
      require('rose-pine').setup({
          variant = "auto", -- 'auto', 'main', 'moon', o 'dawn'
          dark_variant = "main",
          styles = {
              bold = true,
              italic = true,
              transparency = false,
          },
          highlight_groups = {
              -- Normal = { bg = "${config.colors.black}" },
              -- Keyword = { fg = "${config.colors.skyblue}" },
              -- String = { fg = "${config.colors.green}" },
              -- Error = { fg = "${config.colors.red}" },
              -- Warning = { fg = "${config.colors.coral}" },
          }
      })
      vim.cmd('colorscheme rose-pine')

      -- Syntax Highlighting (Treesitter)
      require('nvim-treesitter.configs').setup {
        highlight = { 
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true }
      }

      -- LSPs

      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local servers = { 'nixd', 'pyright', 'rust_analyzer', 'ts_ls', 'html', 'cssls', 'texlab' }

      for _, lsp in ipairs(servers) do 
      	lspconfig[lsp].setup {
	        capabilities = capabilities,
	      }
      end

      -- Keybinds for LSP
      vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, { desc = "Go to Definition" })
      vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = "Hover Documentation" })
      vim.keymap.set('n', '<leader>ca', function() vim.lsp.buf.code_action() end, { desc = "Code Action" })

      -- Autocomplete (nvim-cmp)
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Acepta sugerencia con Enter
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        })
      })

      vim.opt.number = true

      -- Mini-Map
      local codewindow = require('codewindow')
      codewindow.setup({
        active_in_terminals = false,
        auto_enable = false,
        minimap_width = 10, 
      })

      vim.keymap.set('n', '<A-m>', codewindow.toggle_minimap, { desc = "Toggle Minimap"})
    '';
  };
}
