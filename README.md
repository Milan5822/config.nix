# NixOS op een nieuwe laptop instellen

Alle laptops gebruiken dezelfde algemene instellingen uit `configuration.nix` in de hoofdmap. Elke laptop heeft daarnaast een eigen hardwarebestand in `hosts/`.

In dit voorbeeld is `laptop-01` al de bestaande laptop. Daarom gebruiken we `laptop-02` voor de nieuwe laptop. Kies altijd een laptopnummer dat nog niet bij een andere computer hoort. Vervang `laptop-02` in de opdrachten als je een ander nummer gebruikt.

## 1. Git tijdelijk beschikbaar maken

Open de terminal op de nieuwe NixOS-laptop en voer uit:

```sh
nix-shell -p git
```

Dit opent een tijdelijke omgeving waarin Git beschikbaar is. Laat deze terminal open terwijl je de volgende opdrachten uitvoert.

## 2. De repository downloaden

```sh
git clone https://github.com/Milan5822/config.nix.git
```

Dit downloadt de configuratie van GitHub naar de laptop.

```sh
cd ~/config.nix
```

Hiermee ga je naar de map die Git zojuist heeft gedownload.

## 3. Het hardwarebestand van deze laptop toevoegen

```sh
sudo nixos-generate-config --show-hardware-config | sudo tee hosts/laptop-02/hardware-configuration.nix
```

Dit verzamelt de hardwaregegevens van de huidige laptop en schrijft ze in diens eigen hardwarebestand. Zo gebruikt deze laptop niet de hardwaregegevens van `laptop-01` of een andere computer.

## 4. Het hardwarebestand naar GitHub sturen

Voer deze opdrachten één voor één uit:

```sh
git add hosts/laptop-02/hardware-configuration.nix
```

Hiermee vertel je Git dat het nieuwe hardwarebestand moet worden opgeslagen.

```sh
git commit -m "Hardware voor laptop-02 toevoegen"
```

Hiermee geef je de wijziging een herkenbare naam.

```sh
git push
```

Hiermee stuur je de wijziging naar GitHub.

## 5. De configuratie op deze laptop installeren

```sh
sudo nixos-rebuild switch --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
```

`sudo` voert de opdracht uit met de beheerdersrechten die nodig zijn om NixOS aan te passen. `nixos-rebuild switch` bouwt de configuratie en activeert die op deze laptop. `--flake ~/config.nix#laptop-02` kiest de configuratie en het hardwarebestand van laptop-02.

`--extra-experimental-features 'nix-command flakes'` schakelt flakes in voor deze opdracht. NixOS kan flakes standaard nog uit hebben staan; zonder deze optie kan de opdracht dan mislukken. Als flakes al zijn ingeschakeld, kun je de optie weglaten.

Gebruik niet `#laptop-01` voor een nieuwe laptop: daarmee selecteer je de configuratie en hardware van de bestaande laptop-01.
