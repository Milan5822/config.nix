# Bestanden vanuit Verkenner naar GitHub pushen

Met Git kun je bestanden uit een map op je Windows-laptop naar GitHub sturen. Je gebruikt Verkenner om de repositorymap te openen en PowerShell om de wijzigingen te pushen.

## 1. Git installeren

1. Download Git voor Windows via [git-scm.com/download/win](https://git-scm.com/download/win).
2. Start de installatie en gebruik de aanbevolen standaardinstellingen. Laat bij de PATH-instelling de aanbevolen optie geselecteerd: **Git from the command line and also from 3rd-party software**.
3. Rond de installatie af. Sluit PowerShell eventueel af en open het opnieuw.
4. Controleer of Git werkt:

   ```powershell
   git --version
   ```

   Je ziet nu een versienummer.

## 2. De repositorymap openen in Verkenner

1. Open in Verkenner de map `config.nix` die je met GitHub hebt verbonden.
2. Klik bovenaan op de adresbalk, typ `powershell` en druk op **Enter**. PowerShell opent dan in die map.

Controleer of je in de juiste repositorymap staat:

```powershell
git status
```

## 3. Bestanden naar GitHub sturen

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

## Als Git een probleem meldt

- **`git` wordt niet herkend:** sluit PowerShell en open het opnieuw. Controleer daarna met `git --version`.
- **Git vraagt om je naam of e-mailadres:** stel die eenmalig in met je eigen gegevens:

  ```powershell
  git config --global user.name "Je naam"
  git config --global user.email "Je e-mailadres"
  ```

- **`nothing to commit`:** er zijn geen nieuwe wijzigingen gevonden. Controleer of je de bestanden in de repositorymap hebt gezet.
- **Aanmeldfout bij GitHub:** meld je aan wanneer Git daarom vraagt en probeer daarna opnieuw `git push`.
