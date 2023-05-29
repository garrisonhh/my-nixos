{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./protonvpn.nix
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

  # networkmanager
  networking = {
    hostName = "ghh-laptop";
    networkmanager.enable = true; # use NetworkManager for wifi
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    firewall.enable = false;
  };

  # protonvpn thru wireguard using erosa's config
  services.protonvpn = {
    enable = true;
    autostart = true;
    interface.privateKeyFile = "/root/secrets/protonvpn";
    endpoint = {
      publicKey = "qT0lxDVbWEIyrL2A40FfCXRlUALvnryRz2aQdD6gUDs=";
      ip = "89.187.180.40";
    };
  };

  # time zone
  time.timeZone = "America/New_York";

  # i18n
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # bluetooth
  hardware.bluetooth.enable = true;

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
    alacritty    # terminal emulator
    libreoffice  # office utilities

    # config
    home-manager

    # internet
    protonvpn-cli
    networkmanagerapplet
    firefox
    deluge

    # windows emu
    wine
    winetricks
    wineWowPackages.staging
    protontricks
    lutris

    # media
    vlc
    spotify

    # editors
    neovim
    vscodium

    # communication
    slack
    discord

    # cli
    file
    neofetch
    zsh 
    wget
    lsd

    # programming languages and tools (remember, you can always use flakes)
    gnumake
    cmake
    pkg-config

    python311

    gdb
    lldb
    clang
    gcc
    libcxx
    libcxxStdenv

    ocaml
    dune_3
    ocamlPackages.menhir
    ocamlPackages.ocaml-lsp

    rustup

    jdk

    zig
    zls
  ];

  # programs
  programs = {
    zsh.enable = true;
    steam.enable = true;
  };

  # user config
  users.defaultUserShell = pkgs.zsh;
  users.users.garrison = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # versioning
  system = {
    stateVersion = "22.11"; # the version this configuration was created on
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = true;
  };
}
