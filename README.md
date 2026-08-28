<div align="center">

# StoreAMO — entrada desde cero

Este repositorio queda como **compatibilidad multiplataforma y documentación**. En Android, la puerta oficial ya no es una serie `StoreAMO Install 0.0.x`.

## [⬇ Descargar semilla StoreAMO 0.0.1](https://github.com/amoedo7/StoreAMO/releases/download/seed-v0.0.1/StoreAMO-0.0.1.apk)

**StoreAMO 0.0.1 es la semilla canónica, permanente e inmutable del ecosistema.**

</div>

---

## Android — forma oficial

La semilla `StoreAMO 0.0.1` tiene una única pantalla: **Actualizaciones**.

Su trabajo es:

1. pedir a Android autorización para **instalar desde esta fuente**;
2. descargar únicamente la release estable oficial de StoreAMO;
3. verificar el APK con el SHA-256 publicado;
4. entregar el APK a `PackageInstaller`;
5. dejar siempre a Android la confirmación final visible.

Permisos de la semilla: sólo `INTERNET` y `REQUEST_INSTALL_PACKAGES`. No necesita almacenamiento, accesibilidad, overlay, contactos, `QUERY_ALL_PACKAGES` ni permisos de borrado.

Las antiguas pruebas `StoreAMO Install 0.0.5` y `0.0.6` quedan como **historial técnico**. No deben usarse como puerta oficial ni evolucionar a nuevas versiones bootstrap.

### Descarga directa

[**Descargar semilla StoreAMO 0.0.1**](https://github.com/amoedo7/StoreAMO/releases/download/seed-v0.0.1/StoreAMO-0.0.1.apk)

SHA-256 oficial:

https://github.com/amoedo7/StoreAMO/releases/download/seed-v0.0.1/SHA256SUMS.txt

## Android / Termux

```bash
curl -fsSL https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.sh | bash
```

El script descarga la **semilla 0.0.1**, verifica `SHA256SUMS.txt` y abre el APK visible en Android. Después, la propia semilla mantiene instalada/actualizada la Store principal.

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

La semilla no contiene claves privadas ni material de firma. Sólo acepta la distribución oficial de `amoedo7/StoreAMO`, exige HTTPS y SHA-256, y usa la confirmación visible del sistema operativo. No desactiva ni elude Play Protect.

**DesarrollAMO** · un ecosistema, una tienda, una semilla permanente.
