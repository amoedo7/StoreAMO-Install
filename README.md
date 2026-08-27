<div align="center">

# StoreAMO Install

**Una puerta de entrada para instalar o abrir StoreAMO desde distintos dispositivos.**

`Android / Termux` · `Bash` · `Fish` · `PowerShell` · `CMD` · `macOS` · `Linux` · `iPhone / iPad` · `Web`

</div>

---

StoreAMO-Install no contiene aplicaciones ni claves privadas. Resuelve la plataforma y deriva a la experiencia adecuada.

En Android la entrada canónica es **StoreAMO Bootstrap 0.0.2**. Esa semilla está separada del canal estable: se instala una sola vez y, al abrirse, comprueba primero si Android autorizó a StoreAMO como fuente de instalación. Si falta, abre directamente `Permitir desde esta fuente`; cuando el usuario vuelve, continúa sola, descubre la versión estable actual, descarga por HTTPS y usa el pipeline de StoreAMO para verificar integridad/firma y solicitar la actualización.

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

El navegador o Termux puede descargar y abrir el APK, pero **Android exige que el usuario confirme la instalación inicial**. Ningún enlace web puede saltarse esa protección en un teléfono personal normal.

Después de esa única instalación, Bootstrap 0.0.2 cambia el orden del flujo: **autorizar StoreAMO → buscar versión actual → descargar → verificar → solicitar instalación/actualización**. StoreAMO también puede solicitar desinstalaciones oficiales de apps; Android conserva cualquier confirmación final que el sistema exija.

## Regla de seguridad

Android consulta exclusivamente la Release oficial `bootstrap-v0.0.2` de `amoedo7/StoreAMO`, exige los assets `StoreAMO-Bootstrap-0.0.2.apk` y `SHA256SUMS.txt`, restringe ambas URLs al repositorio/tag esperado y verifica SHA-256 antes de abrir el instalador del sistema.

La semilla no es la release `latest` de StoreAMO. El canal moderno sigue siendo `0.4.3.x`; la propia 0.0.2 descubre sólo versiones compatibles de esa línea y vuelve a verificar el artefacto antes de solicitar la actualización.

---

**DesarrollAMO** · un ecosistema, una tienda, varias plataformas.
