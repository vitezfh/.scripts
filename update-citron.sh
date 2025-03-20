#!/bin/bash
set -e pipefail

url="https://api.github.com/repos/pkgforge-dev/Citron-AppImage/releases/latest"
updated_at="$(curl -s $url | jq -r '.assets[0] | .updated_at')"
path="$HOME/Applications/"
filename="citron.AppImage"

if [[ "$updated_at" == "$(cat ~/.citron_timestamp)" ]]; then
  echo "Already up-to-date (delete ~/.citron_timestamp if you want to update anyway)"
  echo "Exiting..."
  exit 0
fi

mkdir -p "$path"
printf "Updating... "
curl -s $url | jq -r '.assets[] | select(.name | endswith("_v3.AppImage")) | .browser_download_url' | wget -q -N -O "$path$filename" -i -
echo "Done!"

sleep 0.5 && printf "Making file executable: \` chmod +x $path$filename \`... "
chmod +x "$path$filename"
echo "$updated_at" >~/.citron_timestamp
echo "Done!"
