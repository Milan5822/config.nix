{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.accounts-daemon.enable = true;

  # Keyboard
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing
  services.printing.enable = true;

  # User
  users.users.milan = {
    isNormalUser = true;
    description = "milan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Packages
  environment.systemPackages = with pkgs; [
    python3
    python3Packages.pygobject3
    gtk4
    libadwaita
    lm_sensors
    smartmontools
    fwupd
    gnome-control-center
    bibata-cursors
    libreoffice
    unzip
    vlc
  ];

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Houd deze waarde gelijk aan de NixOS-release waarmee je systeem is geïnstalleerd.
  system.stateVersion = "26.05";
}
