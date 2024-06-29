#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY -i dash -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix bc jq flock curl cacert
set -eu

getset="${1:-}"

powerLimit=-4000

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"

powerAvailable="$(echo "$power < $powerLimit" | bc)"

if [ "$getset" = "Set" ]; then
  charging="$(cd ../beny && dash ./cmd/charge.sh Get)"
  previousQuarter="$(cd ../homewizard && dash ./cmd/previous_quarterly_yield.sh ./homewizard.db)"
  previousQuarterDrewPower="$(echo "$previousQuarter > 0" | bc)"
  if [ "$charging" = 0 ]; then
    if [ "$powerAvailable" = 1 ] && [ "$previousQuarterDrewPower" = 0 ]; then
      curl "$(cat .beny-notifyurl-start)"
      response="$(dash ./cmd/charge.sh Set '' '' 1)"
    fi
  else
    mode_pv="$(cd ../beny && dash ./cmd/mode_pv.sh Get)"
    if [ "$previousQuarterDrewPower" = 1 ] && [ "$mode_pv" = 1 ]; then
      # there was net power being drawn from the grid, and mode is PV -> stop charging
      curl "$(cat .beny-notifyurl-stop)"
      response="$(dash ./cmd/charge.sh Set '' '' 0)"
    fi
  fi
fi

echo 0
