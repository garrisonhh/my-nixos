{ config, pkgs, ... }:

{
  home = {
    username = "garrison";
    homeDirectory = "/home/garrison";

    # don't change this unless you know what you are doing
    stateVersion = "22.11"; 
  };

  # files in ~/.config/
  xdg.configFile = {
    "awesome/rc.lua".source = "../awesome/rc.lua";
  };

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
}
