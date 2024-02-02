{ pkgs, lib, ...}:

{
  programs.nixvim = {
    extraPlugins = [ pkgs.vimPlugins.catppuccin ];
    colorscheme = "catppuccin";
  };
  
}
