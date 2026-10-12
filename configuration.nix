{ config, pkgs, lib, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # Netwerk
  networking.hostName = lib.mkDefault "nixos";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  # Tijd en taal
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";

  # GNOME-desktop
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.accounts-daemon.enable = true;

  # Toetsenbordindeling (pas aan als je een andere indeling gebruikt)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Afdrukken
  services.printing.enable = true;

  # Laptopcomfort en apparaten
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.fwupd.enable = true;

  # Bestandsbeheer: externe schijven en netwerkshares automatisch aankoppelen
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # Regelmatig opruimen en de Nix-store efficiënt houden
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.settings.auto-optimise-store = true;

  # Periodieke TRIM voor SSD's
  services.fstrim.enable = true;

  # Gebruikersaccount
  users.users.milan = {
    isNormalUser = true;
    description = "milan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Bestaande systeempakketten
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

  # Houd dit gelijk aan de NixOS-release waarmee het systeem is geïnstalleerd.
  system.stateVersion = lib.mkDefault "26.05";
}
