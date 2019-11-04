#!/bin/bash -
set -e
pkill -sighup tor

hs_dir="/var/lib/tor/hidden_services"
echo "Current known onionboats:"
for dir in $(ls $hs_dir); do
  echo "  $dir: $(cat $hs_dir/$dir/hostname)"
done
