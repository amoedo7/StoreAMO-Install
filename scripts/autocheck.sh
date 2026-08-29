#!/usr/bin/env bash
set -euo pipefail

SEED_TAG="seed-v0.0.1"
SEED_APK="StoreAMO-0.0.1.apk"
SEED_SHA256="30e92614c1499b493111412a152db9badfee41ec11345a77381eccb95dc22b05"
API="https://api.github.com/repos/amoedo7/StoreAMO/releases/tags/${SEED_TAG}"
UA="StoreAMO-Seed-AutoCheck/0.0.1"

bash -n install.sh

grep -F 'SEED_TAG="seed-v0.0.1"' install.sh >/dev/null
grep -F 'SEED_APK="StoreAMO-0.0.1.apk"' install.sh >/dev/null
grep -F 'sha256sum -c SHA256SUMS.txt' install.sh >/dev/null
grep -F '"canonical_android_seed": "0.0.1"' .amo >/dev/null
grep -F '"play_protect_bypass_allowed": false' .amo >/dev/null
grep -F 'REQUEST_INSTALL_PACKAGES pertenece sólo a la semilla' .amo >/dev/null
! grep -Eq 'bootstrap-v0\.0\.[2-9]|StoreAMO-Bootstrap-0\.0\.[2-9]|pm[[:space:]]+install|adb[[:space:]]+install' install.sh README.md .amo
! grep -Eq 'REQUEST_DELETE_PACKAGES|QUERY_ALL_PACKAGES' install.sh install.fish install.ps1 install.cmd

code="$(curl -sS -o /tmp/storeamo-seed-release.json -w '%{http_code}' -H "User-Agent: $UA" "$API")"
if [ "$code" != "200" ]; then
  echo "Canonical StoreAMO seed unavailable: HTTP $code" >&2
  exit 1
fi

SEED_SHA256="$SEED_SHA256" python - <<'PY'
import json
import os

x=json.load(open('/tmp/storeamo-seed-release.json', encoding='utf-8'))
assert x.get('tag_name') == 'seed-v0.0.1'
assert x.get('name') == 'StoreAMO 0.0.1 — Semilla'
assert x.get('draft') is False
assert x.get('prerelease') is True
assets=x.get('assets', [])
by_name={a.get('name'): a for a in assets}
assert 'StoreAMO-0.0.1.apk' in by_name
assert 'SHA256SUMS.txt' in by_name
apk=by_name['StoreAMO-0.0.1.apk']
assert apk.get('state') == 'uploaded'
assert apk.get('digest') == f"sha256:{os.environ['SEED_SHA256']}"
PY

echo "StoreAMO-Install AutoCheck PASS: canonical seed 0.0.1 published and digest pinned"
