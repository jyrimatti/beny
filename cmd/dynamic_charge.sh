#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY -i dash -I channel:nixos-23.11-small -p dash coreutils findutils gnused xxd netcat nix bc jq flock curl cacert
set -eu

getset="${1:-}"
service="${2:-}"

powerLimit=-3500

# state file to keep track of whether we started charging dynamically and could thus also stop it.
FILE="${HOMEKIT_SH_CACHE_DIR:-$HOME/.cache/homekit.sh}/beny/dynamic_charge"

mkdir -p "$(dirname "$FILE")"
if [ ! -f "$FILE" ]; then
  touch "$FILE"
fi

if [ "$getset" = "Set" ]; then
  currentQuarter="$(cd ../homewizard && dash ./cmd/current_quarterly_yield.sh ./homewizard.db)"
  currentQuarterDrewPower="$(echo "$currentQuarter > 0.250" | bc)"
  
  if [ "$(dash ./cmd/charge.sh Get)" = 0 ]; then
    echo 0 > "$FILE"
    if [ "$currentQuarterDrewPower" = 0 ]; then
      if [ "$(dash ./cmd/plugged.sh Get)" = 1 ]; then
        power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"
        powerAvailable="$(echo "$power < $powerLimit" | bc)"
        if [ "$powerAvailable" = 1 ]; then
          response="$(dash ./cmd/charge.sh Set '' '' 1)"
          echo 1 > "$FILE"
          dash ./notify_push.sh .beny-notifyurl-start
          echo 1
          exit 0
        fi
      fi
    fi
  else
    if [ "$currentQuarterDrewPower" = 1 ]; then
      if [ "$(cat "$FILE")" = 1 ]; then
        if [ "$(dash ./cmd/mode_pv.sh Get)" = 1 ]; then
          # there was net power being drawn from the grid, and mode is PV -> stop charging
          response="$(dash ./cmd/charge.sh Set '' '' 0)"
          dash ./notify_push.sh .beny-notifyurl-stop
          echo 0
          exit 0
        fi
      fi
    fi
  fi
fi

echo 0
