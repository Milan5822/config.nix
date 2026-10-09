# NixOS-laptops instellen

Deze repository deelt programma's en instellingen via `configuration.nix`. Iedere laptop heeft daarnaast een eigen hostconfiguratie en hardwareconfiguratie in `hosts/`.

Laptop-01 blijft werken met de bestaande hostnaam `nixos`. De gedeelde configuratie gebruikt `nixos` en `stateVersion` 26.05 als standaardwaarden. Een hostbestand kan die waarden voor zijn eigen laptop overschrijven.

De gedeelde configuratie maakt de gebruiker `milan` aan. Gebruik die accountnaam op de nieuwe laptop, of pas `users.users.milan` aan in `configuration.nix`.

## Een laptop-02 tot en met laptop-05 toevoegen

1. Installeer NixOS 26.05 op de laptop en verbind met internet.
2. Open een terminal en maak Git tijdelijk beschikbaar:

   ```sh
   nix-shell -p git
   ```

3. Haal deze repository op:

   ```sh
   git clone https://github.com/Milan5822/config.nix.git ~/config.nix
   cd ~/config.nix
   ```

4. Kies het nummer van deze laptop. Vervang `laptop-02` in het commando hieronder door `laptop-03`, `laptop-04` of `laptop-05` wanneer dat de juiste map is. Genereer de hardwareconfiguratie op de laptop zelf:

   ```sh
   sudo nixos-generate-config --show-hardware-config > hosts/laptop-02/hardware-configuration.nix
   ```

   Dit vervangt de lege placeholder met de hardwaregegevens van de huidige laptop. Gebruik nooit hardwaregegevens van een andere computer.

5. Controleer de hostconfiguratie in `hosts/laptop-02/configuration.nix`. De hostnaam moet bij de gekozen map passen. `stateVersion` moet overeenkomen met de NixOS-versie waarmee deze laptop oorspronkelijk is geïnstalleerd. Als die versie anders is dan 26.05, pas dan alleen de `stateVersion` in dit hostbestand aan.

6. Test op deze laptop. Vervang `laptop-02` door het juiste hostnummer:

   ```sh
   sudo nixos-rebuild test --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
   ```

7. Werkt alles goed? Activeer de configuratie en push de hostbestanden naar GitHub:

   ```sh
   sudo nixos-rebuild switch --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
   git add hosts/laptop-02
   git commit -m "Laptop-02 hardware toegevoegd"
   git push
   ```

Laptop-03, laptop-04 en laptop-05 hebben al een hostmap, flake-vermelding en instellingenbestand. Voor die laptops hoef je alleen hun hardwarebestand te vullen met de opdracht uit stap 4 en de juiste hostnaam in de opdrachten te gebruiken.

## Een volgende laptop toevoegen

Als laptop-02 tot en met laptop-05 allemaal in gebruik zijn, maak dan een nieuwe map onder `hosts/`, voeg een `nixosConfigurations`-vermelding toe in `flake.nix` en maak een hostbestand met de eigen hostnaam en `stateVersion`. Gebruik het hardwarebestand dat op die laptop is gegenereerd.
