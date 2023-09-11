{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/protonvpn.nix
  ];

  # nix ecosystem settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # systemd settings
  systemd = {
    # TODO these settings were for something important but I don't remember what
    # the important thing was
    extraConfig = ''
      DefaultLimitNOFILE=1048576
    '';

    user.extraConfig = ''
      DefaultLimitNOFILE=1048576
    '';
  };

  # networkmanager
  networking = {
    hostName = "ghh-laptop";
    nameservers = [ "1.1.1.1" "8.8.8.8" ];
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
    packages = with pkgs; [
      nerdfonts
      liberation_ttf
    ];

    enableDefaultPackages = true;
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

    # internet
    protonvpn-cli
    networkmanagerapplet
    firefox
    deluge

    # email
    protonmail-bridge
    thunderbird

    # gaming
    lutris
    gamemode
    prismlauncher
    dolphin-emu

    # windows emu (mostly for gaming)
    dxvk
    winetricks
    winePackages.staging
    winePackages.fonts
    protontricks

    # media
    vlc
    spotify

    # editors
    neovim
    vscodium
    retext

    # communication
    slack
    discord

    # cli
    file
    neofetch
    zsh
    wget
    lsd
    htop
    tokei
    zip
    unzip

    # generic programming tools
    git
    git-lfs
    gh
    gnumake
    pkg-config

    # languages + their build tools
    python311

    deno

    gdb
    lldb
    clang
    gcc
    libcxx
    libcxxStdenv
    cmake

    ocaml
    dune_3
    ocamlPackages.menhir
    ocamlPackages.ocaml-lsp

    rustup

    jdk

    zigpkgs."0.11.0"
    zls

    cordova
  ];

  # programs
  programs = {
    steam.enable = true;

    zsh = {
      enable = true;
      shellInit = ''
        source ~/.config/zsh/.p10k.zsh
        alias vi='nvim'
        export EDITOR='nvim'

        PATH="$HOME/.local/bin:$PATH"
      '';
    };
  };

  # virtuualbox
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };

  # user config
  users.defaultUserShell = pkgs.zsh;
  users.users.garrison = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "vboxusers" ];
  };

  # versioning
  system = {
    stateVersion = "22.11"; # the version this configuration was created on
    autoUpgrade.enable = true;
  };
}
