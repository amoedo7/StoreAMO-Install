<div align="center">

# StoreAMO Install

**Una puerta de entrada para instalar o abrir StoreAMO desde distintos dispositivos.**

`Android / Termux` · `Bash` · `Fish` · `PowerShell` · `CMD` · `macOS` · `Linux` · `iPhone / iPad` · `Web`

</div>

---

StoreAMO-Install no contiene aplicaciones ni claves privadas. Resuelve la plataforma, consulta la **Release oficial** de `amoedo7/StoreAMO` cuando corresponde y deriva a la experiencia adecuada.

## Comandos

### Android / Termux · Bash

```bash
curl -fsSL https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.sh | bash
```

### Fish

```fish
curl -fsSL https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.fish | source
```

### Windows · PowerShell

```powershell
irm https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.ps1 | iex
```

### Windows · CMD

```cmd
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.ps1 | iex"
```

### macOS / Linux

El mismo `install.sh` detecta el sistema. Mientras StoreAMO no tenga cliente nativo para esa plataforma, abre/indica StoreAMO Web en lugar de descargar un binario incompatible.

### iPhone / iPad

No intentamos instalar APK. La entrada es **StoreAMO Web/PWA**. Ver [`ios/README.md`](ios/README.md).

## Regla de seguridad

El instalador sólo acepta URLs HTTPS de GitHub Releases del repositorio oficial. En Android descarga el APK de la última Release estable; la propia StoreAMO vuelve a verificar el artefacto según su catálogo antes de distribuir otras apps.

Si todavía no existe una Release oficial, el script **no inventa una descarga**: explica que la versión estable aún no fue publicada.

---

**DesarrollAMO** · un ecosistema, una tienda, varias plataformas.
