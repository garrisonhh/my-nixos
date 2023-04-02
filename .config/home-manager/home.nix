{ config, pkgs, ... }:

{
  home = {
    username = "garrison";
    homeDirectory = "/home/garrison";

    # don't change this unless you know what you are doing
    stateVersion = "22.11"; 
  };

  # applies custom rc.lua to "/etc/xdg/"
  xdg.configFile."awesome/rc.lua".source = ~/.config/awesome/rc.lua;

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "garrisonhh";
      userEmail = "garrisonhh@pm.me";
    };
    gh.enable = true;

    zsh = {
      enable = true;

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };

      oh-my-zsh = {
        enable = true;
        theme="powerlevel10k/powerlevel10k";
        plugins = [
          "git"
          "sudo"
        ];
      };
    };
  };
}
