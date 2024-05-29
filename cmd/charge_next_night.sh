#! /usr/bin/env nix-shell
#! nix-shell -i dash --pure --keep LD_LIBRARY_PATH -I channel:nixos-23.11-small -p dash coreutils xxd netcat nix

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="1";
else
  value="0";
fi

if [ "$getset" = "Set" ]; then
  if [ "$value" = "0" ]; then
    ret="$(dash -x ./beny_cmd.sh "313930303031653234303639303030303030303030303030303030303030303030303030303030303135316630306438")"
  else
    time="30323030303030363030" # 02:00 - 06:00
    ret="$(dash -x ./beny_cmd.sh "31393030303165323430363939396562636138393939656263613839${time}30303135313430303833")"
  fi
  echo "$value"
else
  ret="$(dash ./beny_cmd.sh "3062303030316532343037303964" | tr -d '\n' | tail -c +85 | head -c 24)"
  if [ "$ret" = "303030303030303030303030" ]; then
      echo 0
  else
      echo 1
  fi
fi



#                                                                                               2 == standby
#                                                                                               3 == unplugged
#                                                                            3237==3.9          6 == charging
#           prefix            A3?  A2?  A3?       V1?       V2?       V3?     power             state?   timer from     timer to     Amax?
# 3535616130303030 323237 30 3030 3030 3030 3030 6538 3030 6536 3030 6537 3030 3030 30303030 3665 3032 303030303030 303030303030 3030 3036 3030303030303030 6263
# 3535616130303030 323237 30 3035 3035 3035 3030 6536 3030 6536 3030 6536 3030 3237 30303030 3663 3036 303030303030 303030303030 3030 3036 3030303030303030 6631

# ei lataa
# 3535616130303030 323237 30 3030 3030 3030 3030 6538 3030 6537 3030 6538 3030 3030 30303030 3664 3032 303030303030 303030303030 3030 3036 3030303030303030 6264
# 3535616130303030 323237 30 3030 3030 3030 3030 6536 3030 6561 3030 6537 3030 3030 30303037 3734 3032 303030303030 303030303030 3030 3036 3030303030303030 6362

# lataa
# 3535616130303030 323237 30 3035 3035 3035 3030 6536 3030 6537 3030 6537 3030 3236 30303030 3663 3036 303030303030 303030303030 3030 3036 3030303030303030 6632
# 3535616130303030 323237 30 3035 3035 3035 3030 6536 3030 6537 3030 6537 3030 3236 30303030 3663 3036 303030303030 303030303030 3030 3036 3030303030303030 6632
# 3535616130303030 323237 30 3035 3035 3035 3030 6536 3030 6537 3030 6537 3030 3237 30303030 3663 3036 303030303030 303030303030 3030 3036 3030303030303030 6633
# 3535616130303030 323237 30 3035 3035 3035 3030 6536 3030 6537 3030 6537 3030 3237 30303030 3663 3036 303030303030 303030303030 3030 3036 3030303030303030 6633
# 3535616130303030 323237 30 3035 3035 3035 3030 6561 3030 6538 3030 6561 3030 3237 30303033 3733 3036 303030303030 303030303030 3030 3036 3030303030303030 3035
# 3535616130303030 323237 30 3030 3030 3030 3030 6538 3030 6539 3030 6539 3030 3030 30303030 3732 3036 303030303030 303030303030 3030 3036 3030303030303030 6339
# 3535616130303030 323237 30 3035 3035 3035 3030 6536 3030 6538 3030 6537 3030 3237 30303031 3732 3036 303030303030 303030303030 3030 3036 3030303030303030 6662
# 3535616130303030 323237 30 3035 3035 3035 3030 6535 3030 6537 3030 6537 3030 3236 30303032 3732 3036 303030303030 303030303030 3030 3036 3030303030303030 6639

# 0  030   16 130   32 230
# 1  031   17 131   33 231
# 2  032   18 132   34 232
# 3  033   19 133   35 233
# 4  034   20 134   36 234
# 5  035   21 135   37 235
# 6  036   22 136   38 236
# 7  037   23 137   39 237
# 8  038   24 138   40
# 9  039   25 139   41
# 10 061   26 161   42
# 11 062   27 162   43
# 12 063   28 163   44
# 13 064   29 164   45
# 14 065   30 165   46
# 15 066   31 166   47











