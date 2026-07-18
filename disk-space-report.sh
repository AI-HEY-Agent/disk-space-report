#!/usr/bin/env bash
set -euo pipefail
threshold="${1:-85}"
printf '%-30s %8s %8s %8s %6s %s\n' 'Filesystem' 'Size' 'Used' 'Avail' 'Use%' 'Mount'
df -hP | awk 'NR>1 {print}' | while read -r fs size used avail pct mount; do
  pct_num="${pct%%%}"
  printf '%-30s %8s %8s %8s %6s %s\n' "$fs" "$size" "$used" "$avail" "$pct" "$mount"
  if [ "$pct_num" -ge "$threshold" ]; then
    echo "WARNING: $mount is at $pct usage, threshold is ${threshold}%" >&2
  fi
done

