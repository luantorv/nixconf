{ config, pkgs, globalVars, ... }:

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
      lazygit
      onefetch
      ripgrep
      fd
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

      # Git integration
      lazygit-nvim
      gitsigns-nvim

      # Home Page & Projects
      telescope-nvim
      telescope-project-nvim
      alpha-nvim
      plenary-nvim
    ];

    extraLuaConfig = ''
      vim.deprecate = function() end
      vim.g.mapleader = " "

      local original_deprecate = vim.deprecate
      
      local lspconfig = require('lspconfig')
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Lista de servidores LSP
      local servers = { 'nixd', 'pyright', 'rust_analyzer', 'ts_ls', 'html', 'cssls', 'texlab' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          capabilities = capabilities,
        }
      end

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
        use_git = true,
        use_treesitter = true
      })

      vim.keymap.set('n', '<leader>m', codewindow.toggle_minimap, { desc = "Toggle Minimap"})

      -- Git indicators
      require('gitsigns').setup({
        signs = {
          add          = { text = '│' },
          change       = { text = '│' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
        },
      })

      -- Keybind for LazyGit
      vim.keymap.set('n', '<leader>g', ':LazyGit<CR>', { silent = true, desc = "Abrir LazyGit" })

      -- Changes to Netrw
      vim.g.netrw_winsize = 25
      vim.g.netrw_list_hide = [[\(^\|\s\s\)\(\.git\)\($\|\s\s\)]]

      vim.api.nvim_create_autocmd('filetype', {
        pattern = 'netrw',
        desc = 'Mejoras estéticas para Netrw',
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.keymap.set('n', 'q', ':Lexplore<CR>', { remap = true, buffer = true })
        end
      })

      -- Project Management
      local telescope = require('telescope')

      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        extensions = {
          project = {
            hidden_files = true, 
            theme = "dropdown",  
            order_by = "recent", 
          }
        }
      })

      require('telescope').load_extension('project')

      vim.keymap.set('n', '<leader>fp', ':Telescope project<CR>', { desc = "Buscar Proyectos" })

      -- Home Page (OneFetch)

      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')

      local function get_onefetch()
        local is_git = os.execute("git rev-parse --is-inside-work-tree > /dev/null 2>&1")
        if is_git == 0 then
          local handle = io.popen("onefetch --no-color")
          local result = handle:read("*a")
          handle:close()

          local lines = {}
          
          for line in result:gmatch("([^\n]*)\n") do
            table.insert(lines, line)
          end

          return lines
        else
          return { " ", "    Bienvenido, ${globalVars.username}", " ", "    No se detectó un repositorio Git" }
        end
      end

      dashboard.section.header.val = get_onefetch()
      dashboard.section.header.opts.hl = "String"

      dashboard.section.buttons.val = {
        dashboard.button("p", "󰄉  Proyectos", ":Telescope project<CR>"),
        dashboard.button("f", "󰈞  Buscar archivos", ":Telescope find_files<CR>"),
        dashboard.button("q", "󰅚  Salir", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
      
      -- General Keybind for File Search 
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, { desc = "Buscar archivos" })
    '';
  };
}
