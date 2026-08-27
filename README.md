<div align="center">

# StoreAMO Install

**Una puerta de entrada para instalar o abrir StoreAMO desde distintos dispositivos.**

`Android / Termux` · `Bash` · `Fish` · `PowerShell` · `CMD` · `macOS` · `Linux` · `iPhone / iPad` · `Web`

</div>

---

StoreAMO-Install no contiene aplicaciones ni claves privadas. Resuelve la plataforma y deriva a la experiencia adecuada.

En Android la entrada canónica es **StoreAMO Bootstrap 0.0.3**. La semilla está separada del canal estable y fue diseñada para evitar el bloqueo observado de Google Play Protect: **no declara permisos para instalar ni eliminar otras aplicaciones**. Una vez instalada, descubre la StoreAMO estable oficial y abre su APK mediante HTTPS en el navegador/descargas visibles de Android; el sistema conserva siempre la confirmación de instalación.

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

## Qué hace Android la primera vez

El navegador o Termux descarga y abre el APK, pero **Android exige que el usuario confirme la instalación inicial**. Ningún enlace web puede saltarse esa protección en un teléfono personal normal.

Después de instalar Bootstrap 0.0.3, la app localiza la release estable oficial y abre la descarga correspondiente. StoreAMO mantiene verificación de catálogo/SHA-256, pero la instalación final permanece en la interfaz visible de Android; StoreAMO no se concede a sí misma permisos para instalar aplicaciones arbitrarias.

## Regla de seguridad

Android consulta exclusivamente la Release oficial `bootstrap-v0.0.3` de `amoedo7/StoreAMO`, exige los assets `StoreAMO-Bootstrap-0.0.3.apk` y `SHA256SUMS.txt`, restringe ambas URLs al repositorio/tag esperado y verifica SHA-256 antes de abrir el instalador del sistema.

La semilla no es la release `latest` de StoreAMO. El canal moderno sigue siendo `0.4.3.x`; actualmente la línea segura comienza en `0.4.3.81`. Tanto la semilla como la Store estable carecen de `REQUEST_INSTALL_PACKAGES` y `REQUEST_DELETE_PACKAGES`.

---

**DesarrollAMO** · un ecosistema, una tienda, varias plataformas.
