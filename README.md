# NixOS op een nieuwe laptop

Deze repository gebruikt voor iedere laptop dezelfde algemene instellingen uit `configuration.nix` in de hoofdmap. Elke laptop heeft daarnaast alleen een eigen `hardware-configuration.nix` in `hosts/`. De flake kiest automatisch de juiste hardware en hostnaam.

## Een nieuwe laptop instellen

1. Installeer NixOS en maak verbinding met internet.
2. Open de terminal. Als Git nog niet beschikbaar is, start het tijdelijk met:

   ```sh
   nix-shell -p git
   ```

3. Haal de configuratie op:

   ```sh
   git clone https://github.com/Milan5822/config.nix.git ~/config.nix
   cd ~/config.nix
   ```

4. Kies een laptopnummer dat nog niet in gebruik is. Voor laptop-02 voer je op die laptop uit:

   ```sh
   sudo nixos-generate-config --show-hardware-config > hosts/laptop-02/hardware-configuration.nix
   ```

   Dit vult het hardwarebestand met gegevens van deze laptop. Gebruik voor een volgende laptop het bijbehorende nummer in het pad.

5. Test de configuratie op de laptop:

   ```sh
   sudo nixos-rebuild test --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
   ```

6. Als de test goed werkt, activeer de configuratie:

   ```sh
   sudo nixos-rebuild switch --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
   ```

7. Sla het nieuwe hardwarebestand op in GitHub:

   ```sh
   git add hosts/laptop-02/hardware-configuration.nix
   git commit -m "Hardware voor laptop-02 toevoegen"
   git push
   ```

## Een laptopnummer dat nog niet bestaat

Maak in `hosts/` een map met het volgende nummer en maak daarin een leeg bestand `hardware-configuration.nix`. Voeg vervolgens in `flake.nix` een nieuwe `nixosConfigurations`-vermelding toe, net als bij de andere laptops. Daar verwijs je naar `configuration.nix` in de hoofdmap, stel je de hostnaam in en laad je het hardwarebestand uit de nieuwe map. De handleiding en configuratie hoeven geen apart `configuration.nix`-bestand per laptop te hebben.
