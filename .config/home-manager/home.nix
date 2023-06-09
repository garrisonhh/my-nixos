{ config, pkgs, prismlauncher, ... }:

{
  home = {
    username = "garrison";
    homeDirectory = "/home/garrison";

    # don't change this unless you know what you are doing
    stateVersion = "22.11"; 

    sessionVariables = {
      EDITOR = "nvim";
    };

    packages = [
      # sourced through flake so I can use latest
      prismlauncher.packages.${pkgs.system}.prismlauncher
    ];
  };

  # places custom stuff into xdg.configDir (this is impure)
  xdg.configFile = {
    "awesome/rc.lua".source = ~/.config/awesome/rc.lua;  
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "garrisonhh";
      userEmail = "garrisonhh@pm.me";
    };
    gh.enable = true;

    lsd = {
      enable = true;
      enableAliases = true;

      # these get written to lsd's config.yml
      settings = {
        date = "+%Y %b %0d %X";
        size = "short";
        layout = "oneline";
        sorting.dir-grouping = "last";
      };
    };

    zsh = {
      enable = true;
      initExtra = ''
        source ${config.xdg.configHome}/zsh/.p10k.zsh
        PATH="$PATH:$HOME/.local/bin"
      '';

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; }
          { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
        ];
      };

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
        ];
      };
    };
  };
}
