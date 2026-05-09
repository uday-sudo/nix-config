set -eu

ts="$(date +%Y-%m-%d_%H-%M-%S)"
dir="$HOME/Pictures/Screenshots"
file="$dir/Screenshot_${ts}.png"

mkdir -p "$dir"
region="$(slurp)"
[ -n "$region" ] || exit 0
grim -g "$region" "$file"
wl-copy < "$file"

action="$(
  notify-send \
    --app-name="Screenshot" \
    --icon="$file" \
    --action="edit=Edit in Satty" \
    --action="default=Dismiss" \
    --wait \
    "Screenshot copied" \
    "$file" || true
)"

if [ "$action" = "edit" ]; then
  satty --filename "$file"
fi
