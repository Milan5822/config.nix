# NixOS-configuratie

Kies hieronder welke handleiding je wilt bekijken. Klik op een titel om de stappen te openen.

<details>
<summary><strong>NixOS installeren vanaf een USB-stick</strong></summary>

## NixOS installeren vanaf een USB-stick

Deze handleiding beschrijft een nieuwe installatie op een laptop met de grafische installer. Je maakt de USB-stick met balenaEtcher. De stappen wissen de interne schijf alleen als je in de installer voor **Erase disk** kiest.

### Wat je nodig hebt

- Een USB-stick van minimaal 8 GB. De inhoud van de stick wordt gewist.
- Een werkende internetverbinding en de oplader van de laptop.
- Een back-up van bestanden die je wilt bewaren.

### 1. NixOS en balenaEtcher downloaden

1. Open de [NixOS-downloadpagina](https://nixos.org/download/).
2. Download de **Graphical installer** voor **x86_64**. Dit is de juiste architectuur voor de meeste laptops met een Intel- of AMD-processor. Kies de GNOME-versie; de configuratie in deze repository gebruikt ook GNOME.
3. Download en installeer [balenaEtcher](https://etcher.balena.io/) op de computer waarop je de USB-stick voorbereidt.

De repository gebruikt NixOS 26.05. Kies op de downloadpagina indien mogelijk dezelfde stabiele NixOS-release, zodat de basisinstallatie aansluit op de configuratie.

### 2. De installer op de USB-stick zetten

1. Steek de USB-stick in de computer.
2. Open balenaEtcher en kies **Flash from file**. Selecteer het gedownloade NixOS-ISO-bestand.
3. Kies **Select target** en selecteer de USB-stick. Controleer de naam en grootte goed: de gekozen stick wordt volledig gewist.
4. Klik op **Flash!** en wacht tot Etcher klaar is met schrijven en controleren.
5. Werp de USB-stick veilig uit.

### 3. De laptop vanaf USB starten

1. Sluit de USB-stick aan op de laptop waarop je NixOS wilt installeren en start of herstart de laptop.
2. Open tijdens het opstarten het bootmenu. De toets verschilt per laptop; vaak is dit **F12**, **F10**, **F9**, **Esc** of **Del**.
3. Kies de USB-stick. Als er zowel een gewone als een **UEFI**-optie staat, kies dan de UEFI-optie.
4. Laat de standaard NixOS-installer starten. Na het opstarten verschijnt de live-desktop. Start daar **Install NixOS**.

Als Secure Boot het starten blokkeert, moet je Secure Boot mogelijk tijdelijk uitschakelen in de UEFI-instellingen. De precieze stappen verschillen per laptop.

### 4. De installer invullen

1. Kies de taal en regio.
2. Kies de juiste toetsenbordindeling. Controleer die voordat je het wachtwoord invoert.
3. Vul je naam, gebruikersnaam en een sterk wachtwoord in.
4. Kies **GNOME** als desktopomgeving.
5. Controleer in het scherm voor de schijfindeling dat de installer in **UEFI**-modus is gestart.

### 5. De schijf kiezen en NixOS installeren

Kies in het scherm **Partitioning** de juiste interne schijf.

> **Let op:** kies **Erase disk** alleen als je de volledige geselecteerde schijf mag wissen. Dit verwijdert alle bestaande bestanden en besturingssystemen op die schijf. Maak eerst een back-up en controleer de schijfnaam en -grootte. Wil je Windows behouden of dual-boot gebruiken, kies dan niet voor **Erase disk**; daarvoor is een aparte partitiehandleiding nodig.

1. Kies **Erase disk** voor een volledige, schone installatie. Versleuteling van de schijf is optioneel; bewaar het wachtwoord als je die inschakelt.
2. Bekijk het overzicht zorgvuldig en start de installatie.
3. Wacht tot de installer meldt dat de installatie is voltooid.

### 6. Opstarten in je nieuwe systeem

1. Verwijder de USB-stick wanneer de installer daarom vraagt en herstart de laptop.
2. Meld je aan met de gebruikersnaam en het wachtwoord die je tijdens de installatie hebt ingesteld.
3. Controleer of wifi, toetsenbord, geluid en scherm werken.

Dit installeert een basis-NixOS-systeem. Wil je daarna de configuratie uit deze repository gebruiken, volg dan ook de handleiding **Nieuwe NixOS-laptop instellen**. Controleer daar eerst welk hostnummer bij deze laptop hoort.

Lees voor afwijkende situaties ook de [officiële NixOS-installatiehandleiding](https://nixos.org/manual/nixos/stable/#sec-installation).

</details>

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
