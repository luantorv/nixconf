{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      vim.cmd('colorscheme default')

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

      -- Mostrar buffers
      vim.opt.showtabline = 2

      vim.api.nvim_create_autocmd("TermClose", {
	pattern = "*",
	command = "if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif"
      })
    '';
  };
}
