#!/usr/bin/env bash
set -euo pipefail

SEED_TAG="seed-v0.0.1"
SEED_APK="StoreAMO-0.0.1.apk"
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
if [ "$code" = "200" ]; then
  python - <<'PY'
import json
x=json.load(open('/tmp/storeamo-seed-release.json', encoding='utf-8'))
names={a.get('name') for a in x.get('assets',[])}
assert x.get('tag_name') == 'seed-v0.0.1'
assert x.get('prerelease') is True
assert 'StoreAMO-0.0.1.apk' in names
assert 'SHA256SUMS.txt' in names
PY
elif [ "$code" = "404" ]; then
  echo "StoreAMO 0.0.1 seed release pending publication"
else
  echo "Unexpected GitHub response: HTTP $code" >&2
  exit 1
fi

echo "StoreAMO-Install AutoCheck PASS: canonical seed 0.0.1"
