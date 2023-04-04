{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # nix ecosystem settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # networking
  networking = {
    hostName = "ghh-laptop";
    networkmanager.enable = true; # use NetworkManager for wifi
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # time zone
  time.timeZone = "America/New_York";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Fantasque Sans Mono";
    keyMap = "us";
  };

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # x11 and awesome wm
  services.xserver = {
    enable = true;
    layout = "us";

    libinput.enable = true; # touchpad support
 
    displayManager = {
      sddm.enable = true;
      defaultSession = "none+awesome";
    };

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # lua pkg manager
        luadbi-mysql # lua database layer
      ];
    };
  };

  # fonts
  fonts = {
    fonts = with pkgs; [
      nerdfonts
      liberation_ttf
    ];

    enableDefaultFonts = true;
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" "Symbols Nerd Font" ];
        sansSerif = [ "Liberation Sans" "Symbols Nerd Font" ];
        monospace = [ "agave Nerd Font Mono" "Symbols Nerd Font Mono" ];
      };
    };
  };

  # system packages
  environment.systemPackages = with pkgs; [
    keepassxc    # password manager (TODO move everything from firefox account to this)
    home-manager # system config
    firefox      # browser
    deluge       # torrent client
    vlc          # video player
    spotify      # music
    alacritty    # terminal emulator

    # editors
    neovim
    vscodium

    # communication
    slack
    discord

    # cli
    tree
    neofetch
    zsh 
    wget
    lsd

    # programming languages and tools
    # zig # should probably just use local .nix for zig versions
    python311
    luaformatter
    gdb
    
    ocaml
    dune_3
  ];
  
  # programs
  programs = {
    steam.enable = true;
  };

  # user config
  users.defaultUserShell = pkgs.zsh;
  users.users.garrison = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # wheel allows 'sudo'
  };

  # versioning
  system.stateVersion = "22.11";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}

