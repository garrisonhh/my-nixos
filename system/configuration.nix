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

    # internet
    protonvpn-cli
    networkmanagerapplet
    firefox
    deluge

    # windows emu
    dxvk
    winetricks
      winePackages.staging
    winePackages.fonts
    protontricks
    lutris
    gamemode

    # media
    vlc
    spotify
    prismlauncher

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

    # programming languages and tools (remember, you can always use flakes)
    git
    gh
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

    zigpkgs.master
    zls
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

      #zplug = {
      #  enable = true;
      #  plugins = [
      #    { name = "zsh-users/zsh-autosuggestions"; }
      #    { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      #  ];
      #};

      #oh-my-zsh = {
      #  enable = true;
      #  plugins = [
      #    "git"
      #    "sudo"
      #  ];
      #};
    };
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
