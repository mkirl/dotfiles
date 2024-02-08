{ pkgs, config, ... }:

{
  imports = [
    # Enable &/ Configure Programs
    ./bash.nix
    ./gtk-qt.nix
    ./hyprland.nix
    ./kitty.nix
    ./neofetch.nix
    ./packages.nix
    ./rofi.nix
    ./starship.nix
    ./style1-waybar.nix
    ./style2-waybar.nix
    ./swappy.nix
    ./swaylock.nix
    ./swaync.nix
    ./nixvim.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
