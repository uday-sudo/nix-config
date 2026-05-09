set -eu

ts="$(date +%Y-%m-%d_%H-%M-%S)"
dir="$HOME/Pictures/Screenshots"
file="$dir/Screenshot_${ts}.png"

mkdir -p "$dir"
grim "$file"

action="$(
  notify-send \
    --app-name="Screenshot" \
    --icon="$file" \
    --action="edit=Edit in Satty" \
    --action="default=Dismiss" \
    --wait \
    "Screenshot saved" \
    "$file" || true
)"

if [ "$action" = "edit" ]; then
  satty --filename "$file"
fi
