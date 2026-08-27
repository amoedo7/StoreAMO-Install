#!/usr/bin/env bash
set -euo pipefail

BOOTSTRAP_TAG="bootstrap-v0.0.3"
BOOTSTRAP_APK="StoreAMO-Bootstrap-0.0.3.apk"
API="https://api.github.com/repos/amoedo7/StoreAMO/releases/tags/${BOOTSTRAP_TAG}"
UA="StoreAMO-Install-AutoCheck/1"

bash -n install.sh

grep -F 'BOOTSTRAP_TAG="bootstrap-v0.0.3"' install.sh >/dev/null
grep -F 'sha256sum -c SHA256SUMS.txt' install.sh >/dev/null
grep -F "$BOOTSTRAP_APK" install.sh >/dev/null
! grep -Eq 'REQUEST_INSTALL_PACKAGES|REQUEST_DELETE_PACKAGES|pm[[:space:]]+install|adb[[:space:]]+install' install.sh install.fish install.ps1 install.cmd

release_json="$(curl -fsSL -H "User-Agent: $UA" "$API")"
printf '%s' "$release_json" | python -c '
import json,sys
x=json.load(sys.stdin)
names={a.get("name") for a in x.get("assets",[])}
assert x.get("tag_name") == "bootstrap-v0.0.3"
assert x.get("prerelease") is True
assert "StoreAMO-Bootstrap-0.0.3.apk" in names
assert "SHA256SUMS.txt" in names
'

old_tag="bootstrap-v0.0.2"
old_code="$(curl -sS -o /dev/null -w '%{http_code}' -H "User-Agent: $UA" "https://api.github.com/repos/amoedo7/StoreAMO/releases/tags/${old_tag}")"
test "$old_code" = "404"

echo "StoreAMO-Install AutoCheck PASS"
