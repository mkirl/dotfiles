# PLEASE READ THE WIKI FOR DETERMINING
# VALUES FOR THIS PAGE. 
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options

let
  userHome = "/home/mike";
in
{
  # User Variables
  gitUsername = "michael.e.kirl@gmail.com";
  gitEmail = "michael.e.kirl@gmail.com";
  theme = "catppuccin-mocha";
  waybarStyle = "style2"; # can be style1-2
  borderAnim = true; # anything other than on disables anim borders in Hyprland
  browser = "firefox";
  wallpaperGit = "https://gitlab.com/mkirl/wallpaper-collection.git";
  wallpaperDir = "${userHome}/Pictures/Wallpapers";
  flakeDir = "${userHome}/.dotfiles";
  screenshotDir = "${userHome}/Pictures/Screenshots";

  # System Settings
  theLocale = "en_US.UTF-8";
  theKBDLayout = "us";
  theSecondKBDLayout = "pl";
  theLCVariables = "en_US.UTF-8";
  theTimezone = "America/Chicago";
  cpuType = "intel";
  gpuType = "intel";

  # Optional Settings
  intel-bus-id = "PCI:0:2:0";
  nvidia-bus-id = "PCI:14:0:0";
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";
  localHWClock = false;
  ntp = true;
  printer = false;
  flatpak = false;
  kdenlive = false;
  blender = false;
  logitech = true;
}
