# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page.

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Default timezone
  time.timeZone = "Europe/Amsterdam";

  # Default locale
  i18n.defaultLocale = "en_US.UTF-8";

  # GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  # Your applications/packages
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

  # Firefox
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Don't change this after installation
  system.stateVersion = "26.05";
}
