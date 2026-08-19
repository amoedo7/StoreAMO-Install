#!/usr/bin/env bash
set -euo pipefail

OWNER="amoedo7"
REPO="StoreAMO"
API="https://api.github.com/repos/${OWNER}/${REPO}/releases/latest"
WEB="https://github.com/${OWNER}/StoreAMO-Web"
UA="StoreAMO-Install/1"

say(){ printf '%s\n' "$*"; }
fail(){ say "StoreAMO: $*" >&2; exit 1; }

os="$(uname -s 2>/dev/null || printf unknown)"
is_android=0
if [ -n "${ANDROID_ROOT:-}" ] || [ -d "/data/data/com.termux" ]; then is_android=1; fi

if [ "$is_android" -eq 1 ]; then
  command -v curl >/dev/null 2>&1 || fail "necesito curl. En Termux: pkg install curl"
  json="$(curl -fsSL -H "User-Agent: $UA" "$API" 2>/dev/null || true)"
  [ -n "$json" ] || fail "todavía no existe una Release oficial estable de StoreAMO."
  url="$(printf '%s' "$json" | python -c 'import json,sys; d=json.load(sys.stdin); xs=[a.get("browser_download_url","") for a in d.get("assets",[]) if a.get("name","").lower().endswith(".apk") and a.get("name","").lower().startswith("storeamo")]; print(xs[0] if xs else "")' 2>/dev/null || true)"
  [ -n "$url" ] || fail "la última Release no contiene un APK StoreAMO."
  case "$url" in https://github.com/${OWNER}/${REPO}/releases/download/*) ;; *) fail "origen de descarga inesperado";; esac
  outdir="${HOME}/downloads/StoreAMO"
  mkdir -p "$outdir"
  outfile="$outdir/StoreAMO.apk"
  say "Descargando StoreAMO oficial…"
  curl -fL --retry 2 -H "User-Agent: $UA" "$url" -o "$outfile"
  say "APK: $outfile"
  if command -v termux-open >/dev/null 2>&1; then
    termux-open "$outfile"
    say "Android debería mostrar ahora el instalador del sistema."
  else
    say "Abrí manualmente el APK para instalarlo."
  fi
  exit 0
fi

say "StoreAMO nativo todavía no está publicado para ${os}."
say "Usá StoreAMO Web: ${WEB}"
if command -v xdg-open >/dev/null 2>&1; then xdg-open "$WEB" >/dev/null 2>&1 || true; fi
if command -v open >/dev/null 2>&1; then open "$WEB" >/dev/null 2>&1 || true; fi
