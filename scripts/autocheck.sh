#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_TAG="bootstrap-v0.0.5"
BOOTSTRAP_APK="StoreAMO-Bootstrap-0.0.5.apk"
API="https://api.github.com/repos/amoedo7/StoreAMO/releases/tags/${BOOTSTRAP_TAG}"
UA="StoreAMO-Install-AutoCheck/5"

bash -n install.sh

grep -F 'BOOTSTRAP_TAG="bootstrap-v0.0.5"' install.sh >/dev/null
grep -F 'BOOTSTRAP_APK="StoreAMO-Bootstrap-0.0.5.apk"' install.sh >/dev/null
grep -F 'sha256sum -c SHA256SUMS.txt' install.sh >/dev/null
grep -F 'play_protect_bypass_allowed' .amo >/dev/null
grep -F '"play_protect_bypass_allowed": false' .amo >/dev/null
grep -F 'REQUEST_INSTALL_PACKAGES pertenece sólo al helper dedicado' .amo >/dev/null
! grep -Eq 'REQUEST_DELETE_PACKAGES|QUERY_ALL_PACKAGES|pm[[:space:]]+install|adb[[:space:]]+install' install.sh install.fish install.ps1 install.cmd

# La release puede no existir todavía mientras el PR que la prepara está en CI.
# Si ya existe, su identidad y assets pasan a ser parte del AutoCheck.
code="$(curl -sS -o /tmp/storeamo-install-release.json -w '%{http_code}' -H "User-Agent: $UA" "$API")"
if [ "$code" = "200" ]; then
  python - <<'PY'
import json
x=json.load(open('/tmp/storeamo-install-release.json', encoding='utf-8'))
names={a.get('name') for a in x.get('assets',[])}
assert x.get('tag_name') == 'bootstrap-v0.0.5'
assert x.get('prerelease') is True
assert 'StoreAMO-Bootstrap-0.0.5.apk' in names
assert 'SHA256SUMS.txt' in names
PY
elif [ "$code" = "404" ]; then
  echo "StoreAMO Install 0.0.5 release pending publication"
else
  echo "Unexpected GitHub response: HTTP $code" >&2
  exit 1
fi

echo "StoreAMO-Install AutoCheck PASS"
