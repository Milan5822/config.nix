# Nieuwe laptop instellen

De algemene instellingen staan in `configuration.nix` in de hoofdmap. Elke laptop heeft alleen een eigen hardwarebestand in `hosts/`. In dit voorbeeld gebruiken we `laptop-02`; vervang dat nummer als je een andere laptopmap gebruikt.

## Configuratie ophalen en hardware toevoegen

Open de terminal op de nieuwe laptop en voer de opdrachten één voor één uit:

```sh
nix-shell -p git
git clone https://github.com/Milan5822/config.nix.git
cd ~/config.nix
sudo nixos-generate-config --show-hardware-config | sudo tee hosts/laptop-02/hardware-configuration.nix
git add hosts/laptop-02/hardware-configuration.nix
git commit -m "Hardware voor laptop-02 toevoegen"
git push
```

De hardwareopdracht zet de hardwaregegevens van deze laptop rechtstreeks in de juiste map. Zo worden ze samen met de gedeelde configuratie op GitHub bewaard.

## Configuratie installeren

Voer daarna uit:

```sh
sudo nixos-rebuild switch --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
```

Vervang in de opdrachten `laptop-02` door het nummer van de laptop die je instelt. Gebruik voor elke laptop een eigen map en vul het hardwarebestand op die laptop zelf.
