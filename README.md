# NixOS-configuratie

Kies hieronder welke handleiding je wilt bekijken. Klik op een titel om de stappen te openen.

<details>
<summary><strong>Nieuwe NixOS-laptop instellen</strong></summary>

## NixOS op een nieuwe laptop instellen

Alle laptops gebruiken dezelfde algemene instellingen uit `configuration.nix` in de hoofdmap. Elke laptop heeft daarnaast een eigen hardwarebestand in `hosts/`.

In dit voorbeeld is `laptop-01` al de bestaande laptop. Daarom gebruiken we `laptop-02` voor de nieuwe laptop. Kies altijd een laptopnummer dat nog niet bij een andere computer hoort. Vervang `laptop-02` in de opdrachten als je een ander nummer gebruikt.

### 1. Git tijdelijk beschikbaar maken

Open de terminal op de nieuwe NixOS-laptop en voer uit:

```sh
nix-shell -p git
```

Dit opent een tijdelijke omgeving waarin Git beschikbaar is. Laat deze terminal open terwijl je de volgende opdrachten uitvoert.

### 2. De repository downloaden

```sh
git clone https://github.com/Milan5822/config.nix.git
```

Dit downloadt de configuratie van GitHub naar de laptop.

```sh
cd ~/config.nix
```

Hiermee ga je naar de map die Git zojuist heeft gedownload.

### 3. Het hardwarebestand van deze laptop toevoegen

```sh
sudo nixos-generate-config --show-hardware-config | sudo tee hosts/laptop-02/hardware-configuration.nix
```

Dit verzamelt de hardwaregegevens van de huidige laptop en schrijft ze in diens eigen hardwarebestand. Zo gebruikt deze laptop niet de hardwaregegevens van `laptop-01` of een andere computer.

### 4. Het hardwarebestand naar GitHub sturen

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

### 5. De configuratie op deze laptop installeren

```sh
sudo nixos-rebuild switch --extra-experimental-features 'nix-command flakes' --flake ~/config.nix#laptop-02
```

`sudo` voert de opdracht uit met de beheerdersrechten die nodig zijn om NixOS aan te passen. `nixos-rebuild switch` bouwt de configuratie en activeert die op deze laptop. `--flake ~/config.nix#laptop-02` kiest de configuratie en het hardwarebestand van laptop-02.

`--extra-experimental-features 'nix-command flakes'` schakelt flakes in voor deze opdracht. NixOS kan flakes standaard nog uit hebben staan; zonder deze optie kan de opdracht dan mislukken. Als flakes al zijn ingeschakeld, kun je de optie weglaten.

Gebruik niet `#laptop-01` voor een nieuwe laptop: daarmee selecteer je de configuratie en hardware van de bestaande laptop-01.

</details>

<details>
<summary><strong>Bestanden vanuit Windows naar GitHub pushen</strong></summary>

## Bestanden vanuit Windows naar GitHub pushen

Dit onderdeel is voor het aanpassen en pushen van bestanden vanaf een Windows-laptop. Het is een apart proces van het installeren van NixOS hierboven.

### 1. Git installeren

1. Download Git voor Windows via [git-scm.com/download/win](https://git-scm.com/download/win).
2. Start de installatie en gebruik de aanbevolen standaardinstellingen. Laat bij de PATH-instelling de aanbevolen optie geselecteerd: **Git from the command line and also from 3rd-party software**.
3. Rond de installatie af. Sluit PowerShell eventueel af en open het opnieuw.
4. Controleer of Git werkt:

   ```powershell
   git --version
   ```

   Je ziet nu een versienummer.

### 2. De repositorymap openen in Verkenner

1. Open in Verkenner de map `config.nix` die je met GitHub hebt verbonden.
2. Klik bovenaan op de adresbalk, typ `powershell` en druk op **Enter**. PowerShell opent dan in die map.

Controleer of je in de juiste repositorymap staat:

```powershell
git status
```

### 3. Bestanden naar GitHub sturen

Nadat je bestanden in de repositorymap hebt aangepast of geplakt, voer je deze opdrachten één voor één uit:

```powershell
git add .
```

Hiermee selecteer je alle nieuwe en aangepaste bestanden in de repositorymap om op te slaan.

```powershell
git commit -m "Beschrijf hier kort je wijziging"
```

Hiermee sla je de geselecteerde wijzigingen op met een korte beschrijving. Vervang de tekst tussen aanhalingstekens door bijvoorbeeld `Hardware voor laptop-02 toegevoegd`.

```powershell
git push
```

Hiermee stuur je de opgeslagen wijzigingen naar GitHub. Als Git daarom vraagt, meld je aan met je GitHub-account.

### Als Git een probleem meldt

- **`git` wordt niet herkend:** sluit PowerShell en open het opnieuw. Controleer daarna met `git --version`.
- **Git vraagt om je naam of e-mailadres:** stel die eenmalig in met je eigen gegevens:

  ```powershell
  git config --global user.name "Je naam"
  git config --global user.email "Je e-mailadres"
  ```

- **`nothing to commit`:** er zijn geen nieuwe wijzigingen gevonden. Controleer of je de bestanden in de repositorymap hebt gezet.
- **Aanmeldfout bij GitHub:** meld je aan wanneer Git daarom vraagt en probeer daarna opnieuw `git push`.

</details>
