{ config, pkgs, ... }:

{
  home.username = "garrison";
  home.homeDirectory = "/home/garrison";

  # don't change this unless you know what you are doing
  home.stateVersion = "22.11"; 
  
  # program config
  programs = {
    home-manager.enable = true;
    zsh.enable = true;
    git = {
      enable = true;
      userName = "garrisonhh";
      userEmail = "garrisonhh@pm.me";
    };
    gh.enable = true;
  };

  # local packages
  # home.packages = [];

  # managing dotfiles
  # home.file = {};
}
