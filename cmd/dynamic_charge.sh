#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix bc jq flock curl cacert
set -eu

getset="${1:-}"

powerLimit=-4000

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"
charging="$(cd ../beny && dash ./cmd/charge.sh Get)"

powerAvailable="$(echo "$power < $powerLimit" | bc)"


if [ "$getset" = "Set" ]; then
  if [ "$powerAvailable" = 1 ]; then
    if [ "$charging" = 0 ]; then
      response="$(dash ./cmd/charge.sh Set 1)"
    fi
  else
    if [ "$charging" = 1 ]; then
      response="$(dash ./cmd/charge.sh Set 0)"
    fi
  fi
fi

echo "$powerAvailable"
