{ pkgs, lib, ...}:

{
  programs.nixvim = {

    options = {
      relativenumber = true;
      incsearch = true;
    };

    plugins = {
      telescope.enable = true;
      harpoon = {
        enable = true;
	keymaps.addFile = "<leader>a";
      };
    };

    extraPlugins = [ pkgs.vimPlugins.catppuccin-nvim ];
    colorscheme = "catppuccin";
  };
  
}
