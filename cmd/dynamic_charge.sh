#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY -i dash -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix bc jq flock curl cacert
set -eu

getset="${1:-}"

powerLimit=-4000
stopLimit=1000

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"
charging="$(cd ../beny && dash ./cmd/charge.sh Get)"

powerAvailable="$(echo "$power < $powerLimit" | bc)"
powerDeficit="$(echo "$power > $stopLimit" | bc)"


if [ "$getset" = "Set" ]; then
  if [ "$powerAvailable" = 1 ]; then
    if [ "$charging" = 0 ]; then
      response="$(dash ./cmd/charge.sh Set '' '' 1)"
    fi
  elif [ "$charging" = 1 ] && [ "$powerDeficit" = 1 ]; then
      response="$(dash ./cmd/charge.sh Set '' '' 0)"
  fi
fi

echo 0
