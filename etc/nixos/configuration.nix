# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    <home-manager/nixos>
  ];

  # nix ecosystem settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "ghh-laptop";
  # networking.wireless.enable = true; # use wpa_supplicant for wifi
  networking.networkmanager.enable = true; # use NetworkManager for wifi
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # time zone
  time.timeZone = "America/New_York";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
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

  # system packages
  environment.systemPackages = with pkgs; [
    keepassxc    # password manager (TODO move everything from firefox account to this)
    home-manager # system config
    firefox      # browser
    deluge       # torrent client
    vlc          # video player

    # editors
    neovim
    vscodium

    # communication
    slack
    discord

    # cli
    alacritty
    zsh 
    wget

    # programming languages and tools
    # zig # should probably just use local .nix for zig versions
    python311
    luaformatter
    gdb
  ];

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

