<div align="center">

# StoreAMO Install

**La puerta de entrada mínima y verificable para instalar y actualizar StoreAMO.**

Android / Termux · Bash · Fish · Windows · macOS · Linux · iPhone / iPad · Web

</div>

---

## Android — la forma recomendada

StoreAMO usa ahora el mismo principio de seguridad de una tienda alternativa como F-Droid: **la tienda y el instalador están separados**.

- `StoreAMO` navega catálogo, verifica metadatos y no tiene permiso para instalar paquetes.
- `StoreAMO Install` es un helper mínimo con paquete propio `com.desarrollamo.storeamo.bootstrap`.
- Sólo declara `INTERNET` y `REQUEST_INSTALL_PACKAGES`.
- Antes de descargar, Android te pide autorizar **StoreAMO Install** como fuente.
- El helper acepta únicamente la release estable oficial de `amoedo7/StoreAMO`, exige HTTPS y verifica SHA-256.
- La instalación se entrega a `PackageInstaller`: **Android conserva siempre la confirmación final**.
- StoreAMO Install no desactiva, modifica ni elude Play Protect.

### Descarga directa

Cuando `bootstrap-v0.0.5` esté publicado, el APK canónico es:

`https://github.com/amoedo7/StoreAMO/releases/download/bootstrap-v0.0.5/StoreAMO-Bootstrap-0.0.5.apk`

Y su suma oficial:

`https://github.com/amoedo7/StoreAMO/releases/download/bootstrap-v0.0.5/SHA256SUMS.txt`

Flujo:

1. Descargá **StoreAMO Install 0.0.5** desde la release oficial.
2. Android puede pedir permiso al navegador/gestor de archivos para instalar esa primera APK.
3. Abrí **StoreAMO Install**.
4. Tocá **Instalar / actualizar StoreAMO**.
5. La app abre directamente la pantalla Android de **Permitir desde esta fuente** si todavía falta autorización.
6. Al volver, descarga StoreAMO, verifica SHA-256 y abre la confirmación de instalación del sistema.

No recomendamos desactivar Play Protect globalmente. Si Android o Play Protect bloquean una instalación, el helper conserva y muestra el resultado del sistema en lugar de ocultarlo.

## Android / Termux

```bash
curl -fsSL https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.sh | bash
```

El script descarga **StoreAMO Install**, verifica `SHA256SUMS.txt` y abre el APK visible en Android. Después las instalaciones/actualizaciones de StoreAMO pasan por el helper.

## Fish

```fish
curl -fsSL https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.fish | source
```

## Windows · PowerShell

```powershell
irm https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.ps1 | iex
```

## Windows · CMD

```cmd
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.ps1 | iex"
```

## macOS / Linux

`install.sh` detecta la plataforma. Mientras no exista cliente nativo, deriva a StoreAMO Web en lugar de descargar un APK incompatible.

## iPhone / iPad

No se intenta instalar APK. La entrada es StoreAMO Web/PWA. Ver [`ios/README.md`](ios/README.md).

## Frontera de seguridad

StoreAMO Install nunca contiene claves privadas ni material de firma. La release de producción se firma en el pipeline protegido de StoreAMO con la identidad release persistente. El repositorio de entrada sólo contiene rutas públicas, verificaciones y documentación.

**DesarrollAMO** · un ecosistema, una tienda, una frontera de instalación explícita.
