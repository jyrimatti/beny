#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY -i dash -I channel:nixos-23.11-small -p dash coreutils findutils gnused xxd netcat nix bc jq flock curl cacert
set -eu

getset="${1:-}"
service="${2:-}"
characteristic="${3:-}"

powerLimit=-4000

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"

powerAvailable="$(echo "$power < $powerLimit" | bc)"

if [ "$getset" = "Set" ]; then
  charging="$(cd ../beny && dash ./cmd/charge.sh Get)"
  plugged="$(cd ../beny && dash ./cmd/plugged.sh Get)"
  previousQuarter="$(cd ../homewizard && dash ./cmd/previous_quarterly_yield.sh ./homewizard.db)"
  previousQuarterDrewPower="$(echo "$previousQuarter > 0" | bc)"
  if [ "$charging" = 0 ]; then
    if [ "$plugged" = 1 ] && [ "$powerAvailable" = 1 ] && [ "$previousQuarterDrewPower" = 0 ]; then
      dash ./notify.sh "$(echo "$service" | jq -r '.aid')" "$(echo "$characteristic" | jq -r '.iid')" 1
      response="$(dash ./cmd/charge.sh Set '' '' 1)"
      echo 1
      exit 0
    fi
  else
    mode_pv="$(cd ../beny && dash ./cmd/mode_pv.sh Get)"
    if [ "$previousQuarterDrewPower" = 1 ] && [ "$mode_pv" = 1 ]; then
      # there was net power being drawn from the grid, and mode is PV -> stop charging
      dash ./notify.sh "$(echo "$service" | jq -r '.aid')" "$(echo "$characteristic" | jq -r '.iid')" 0
      response="$(dash ./cmd/charge.sh Set '' '' 0)"
      echo 0
      exit 0
    fi
  fi
fi

echo 0
