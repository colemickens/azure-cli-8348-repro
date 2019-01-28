#!/usr/bin/env bash
set -euo pipefail

function az() { ./az.sh "${@}" --subscription "${AZURE_SUBSCRIPTION_ID}"; }
export AZURE_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID:-"aff271ee-e9be-4441-b9bb-42f5af4cbaeb"}" 

rg="nixos"
d="nixos-image-16.09.1694.019dcc3-x86_64-linux.vhd"

#imgid="$(az image show -n "${d}" -g "${rg}" --q "[id]" -o tsv)"
imgid="$(az image show -n "${d}" -g "${rg}" --q "[id]" -o tsv | tr -d '\r')"
echo -n "${imgid}"
exit 0

