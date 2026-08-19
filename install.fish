#!/usr/bin/env fish
set -l script (mktemp -t storeamo-install.XXXXXX)
if not curl -fsSL https://raw.githubusercontent.com/amoedo7/StoreAMO-Install/main/install.sh -o $script
    echo 'StoreAMO: no pude descargar install.sh' >&2
    rm -f $script
    return 1
end
bash $script
set -l code $status
rm -f $script
return $code
