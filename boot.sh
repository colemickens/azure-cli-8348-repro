#!/usr/bin/env bash
set -euo pipefail

function az() { ./az.sh "${@}" --subscription "${AZURE_SUBSCRIPTION_ID}"; }
export AZURE_LOCATION="${AZURE_LOCATION:="westus2"}"
export AZURE_SUBSCRIPTION_ID="${AZURE_SUBSCRIPTION_ID:-"aff271ee-e9be-4441-b9bb-42f5af4cbaeb"}" 

rg="nixos-user-${AZURE_LOCATION}"
size="Standard_D32s_v3"
adminUsername="azureuser"
sshpubkey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC9YAN+P0umXeSP/Cgd5ZvoD5gpmkdcrOjmHdonvBbptbMUbI/Zm0WahBDK0jO5vfJ/C6A1ci4quMGCRh98LRoFKFRoWdwlGFcFYcLkuG/AbE8ObNLHUxAwqrdNfIV6z0+zYi3XwVjxrEqyJ/auZRZ4JDDBha2y6Wpru8v9yg41ogeKDPgHwKOf/CKX77gCVnvkXiG5ltcEZAamEitSS8Mv8Rg/JfsUUwULb6yYGh+H6RECKriUAl9M+V11SOfv8MAdkXlYRrcqqwuDAheKxNGHEoGLBk+Fm+orRChckW1QcP89x6ioxpjN9VbJV0JARF+GgHObvvV+dGHZZL1N3jr8WtpHeJWxHPdBgTupDIA5HeL0OCoxgSyyfJncMl8odCyUqE+lqXVz+oURGeRxnIbgJ07dNnX6rFWRgQKrmdV4lt1i1F5Uux9IooYs/42sKKMUQZuBLTN4UzipPQM/DyDO01F0pdcaPEcIO+tp2U6gVytjHhZqEeqAMaUbq7a6ucAuYzczGZvkApc85nIo9jjW+4cfKZqV8BQfJM1YnflhAAplIq6b4Tzayvw1DLXd2c5rae+GlVCsVgpmOFyT6bftSon/HfxwBE4wKFYF7fo7/j6UbAeXwLafDhX+S5zSNR6so1epYlwcMLshXqyJePJNhtsRhpGLd9M3UqyGDAFoOQ== cardno:000607532298"

imgid="$(./img.sh)"

az group create -l "${AZURE_LOCATION}" -n "${rg}"

az vm create \
  --debug \
  --name "nixos-test-${RANDOM}" \
  -g "${rg}" \
  --image "${imgid}" \
  --os-disk-size-gb 50 \
  --admin-username "${adminUsername}" \
  --ssh-key-value "${sshpubkey}" \
  --size "${size}" \
  --location "${AZURE_LOCATION}"

