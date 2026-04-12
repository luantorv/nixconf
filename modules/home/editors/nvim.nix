{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

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
    '';
  };
}