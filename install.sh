#!/usr/bin/env bash
set -euo pipefail

OWNER="amoedo7"
REPO="StoreAMO"
SEED_TAG="seed-v0.0.1"
SEED_APK="StoreAMO-0.0.1.apk"
API="https://api.github.com/repos/${OWNER}/${REPO}/releases/tags/${SEED_TAG}"
WEB="https://github.com/${OWNER}/StoreAMO-Web"
UA="StoreAMO-Seed/0.0.1"

say(){ printf '%s\n' "$*"; }
fail(){ say "StoreAMO: $*" >&2; exit 1; }

os="$(uname -s 2>/dev/null || printf unknown)"
is_android=0
if [ -n "${ANDROID_ROOT:-}" ] || [ -d "/data/data/com.termux" ]; then is_android=1; fi

if [ "$is_android" -eq 1 ]; then
  command -v curl >/dev/null 2>&1 || fail "necesito curl. En Termux: pkg install curl"
  command -v python >/dev/null 2>&1 || fail "necesito Python para validar la respuesta oficial."
  command -v sha256sum >/dev/null 2>&1 || fail "necesito sha256sum para verificar el APK."

  json="$(curl -fsSL -H "User-Agent: $UA" "$API" 2>/dev/null || true)"
  [ -n "$json" ] || fail "la semilla StoreAMO 0.0.1 no está publicada o GitHub no respondió."

  readarray -t assets < <(printf '%s' "$json" | python -c 'import json,sys; d=json.load(sys.stdin); a={x.get("name",""):x.get("browser_download_url","") for x in d.get("assets",[])}; print(a.get("StoreAMO-0.0.1.apk","")); print(a.get("SHA256SUMS.txt",""))' 2>/dev/null)
  apk_url="${assets[0]:-}"
  sums_url="${assets[1]:-}"
  [ -n "$apk_url" ] || fail "la release no contiene la semilla esperada."
  [ -n "$sums_url" ] || fail "la release no contiene SHA256SUMS.txt."

  case "$apk_url" in https://github.com/${OWNER}/${REPO}/releases/download/${SEED_TAG}/*) ;; *) fail "origen APK inesperado";; esac
  case "$sums_url" in https://github.com/${OWNER}/${REPO}/releases/download/${SEED_TAG}/*) ;; *) fail "origen SHA inesperado";; esac

  outdir="${HOME}/downloads/StoreAMO"
  mkdir -p "$outdir"
  outfile="$outdir/$SEED_APK"
  sumsfile="$outdir/SHA256SUMS.txt"

  say "Descargando semilla StoreAMO 0.0.1 oficial…"
  curl -fL --retry 2 -H "User-Agent: $UA" "$apk_url" -o "$outfile"
  curl -fL --retry 2 -H "User-Agent: $UA" "$sums_url" -o "$sumsfile"
  (cd "$outdir" && sha256sum -c SHA256SUMS.txt >/dev/null) || fail "SHA-256 del APK no coincide."
  say "Semilla verificada: $outfile"

  if command -v termux-open >/dev/null 2>&1; then
    termux-open "$outfile"
    say "Android debería mostrar el instalador. Abrí StoreAMO 0.0.1, autorizá ‘Permitir desde esta fuente’ y usá su única pantalla Actualizaciones para instalar o actualizar la Store principal."
  else
    say "Abrí manualmente $outfile y seguí la pantalla Actualizaciones de StoreAMO 0.0.1."
  fi
  exit 0
fi

say "StoreAMO nativo todavía no está publicado para ${os}."
say "Usá StoreAMO Web: ${WEB}"
if command -v xdg-open >/dev/null 2>&1; then xdg-open "$WEB" >/dev/null 2>&1 || true; fi
if command -v open >/dev/null 2>&1; then open "$WEB" >/dev/null 2>&1 || true; fi
