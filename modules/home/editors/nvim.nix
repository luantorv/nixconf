# SPDX-FileCopyrightText: 2026 Luis Reis Viera
# SPDX-License-Identifier: Apache-2.0

{ config, pkgs, globalVars, nixpkgs-old, ... }:

let
  pkgsOld = nixpkgs-old.legacyPackages.${globalVars.system};
in
{
  programs.neovim = {
    enable = true;
    package = pkgsOld.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # LSP Servers
    extraPackages = with pkgs; [
      gcc
      tree-sitter
	    nixd					                # Nix
	    pyright					              # Python
	    rust-analyzer				          # Rust
	    typescript-language-server	  # JS/TS
	    vscode-langservers-extracted  # HTML/CSS/JSON/ESLint
	    texlab					              # LaTeX
      lazygit
      onefetch
      ripgrep
      fd
    ];

    plugins = with pkgsOld.vimPlugins; [
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

    initLua = ''
      -- Options
      ${builtins.readFile ./lua/options.lua}

      -- Lista de servidores LSP
      ${builtins.readFile ./lua/LSPs.lua}

      -- Keybinds
      ${builtins.readFile ./lua/keybinds.lua}

      -- Git Integration
      ${builtins.readFile ./lua/git.lua}

      -- Color Theme
      ${builtins.readFile ./lua/theme.lua}

      -- MiniMap
      ${builtins.readFile ./lua/minimap.lua}

      -- Project Management (Telescope)
      ${builtins.readFile ./lua/telescope.lua}

      -- Home Page (OneFetch)
      ${builtins.readFile ./lua/onefetch.lua}

      -- Explorador de archivos
      ${builtins.readFile ./lua/netrw.lua}
      
      -- Tabline
      ${builtins.readFile ./lua/tabline.lua}

      -- Syntax Highlighting (Treesitter)
      ${builtins.readFile ./lua/treesitter.lua}

      -- Autocomplete (nvim-cmp)
      ${builtins.readFile ./lua/autocomplete.lua}
    '';
  };
}
