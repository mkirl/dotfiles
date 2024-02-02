{ pkgs, lib, ...}:

{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.catppuccin-nvim ];
    colorscheme = "catppuccin-nvim";
  };
  
}
