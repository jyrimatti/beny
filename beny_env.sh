#!/bin/sh

export BENY_HOST="$(cat "${CREDENTIALS_DIRECTORY:-.}/.beny-host")"
export BENY_PORT="$(cat "${CREDENTIALS_DIRECTORY:-.}/.beny-port")"

export BENY_PREFIX="3535616130303030"

convert() {
  read -r x
  a16="$x / 100"
  a10="$x % 100 / 10 / 3 - 1"
  a1="$x % 10"
  echo "($a16) * 16 + ($a10) * 10 + ($a1) - ($a10)" | bc
}