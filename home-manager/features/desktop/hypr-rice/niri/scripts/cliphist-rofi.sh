set -eu

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/cliphist-rofi"
mkdir -p "$cache_dir"

if [ -n "${ROFI_INFO:-}" ]; then
  cliphist decode "$ROFI_INFO" | wl-copy
  exit 0
fi

cliphist list | while IFS="$(printf '\t')" read -r id preview; do
  [ -n "$id" ] || continue
  preview="${preview:-$id}"

  if printf '%s' "$preview" | grep -q '^\[\[ binary data .* \]\]$'; then
    icon="$cache_dir/$id.png"
    if [ ! -s "$icon" ]; then
      cliphist decode "$id" >"$icon" 2>/dev/null || true
    fi

    if [ -s "$icon" ]; then
      printf '%s\0icon\x1f%s\x1finfo\x1f%s\n' "$preview" "$icon" "$id"
      continue
    fi
  fi

  printf '%s\0info\x1f%s\n' "$preview" "$id"
done
