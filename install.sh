#!/usr/bin/env bash
# Desktop profiles asset installer — user-local only, no GDM/system changes.
set -e

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "== Installing launchers =="
mkdir -p "$HOME/.local/share/applications"
install -Dm644 "$SRC/assets/launchers/"*.desktop "$HOME/.local/share/applications/"

echo "== Installing icons =="
install -Dm644 "$SRC/assets/icons/windows-logo.svg" "$HOME/.local/share/icons/windows-logo.svg"
install -Dm644 "$SRC/assets/icons/arcmenu-logo.svg" "$HOME/.local/share/icons/arcmenu-logo.svg"
install -Dm644 "$SRC/assets/icons/hicolor/512x512/apps/ms-store.png" \
    "$HOME/.local/share/icons/hicolor/512x512/apps/ms-store.png"
install -Dm644 "$SRC/assets/icons/hicolor/128x128/apps/ms-store.png" \
    "$HOME/.local/share/icons/hicolor/128x128/apps/ms-store.png"
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

echo "== Installing wallpapers =="
install -Dm644 "$SRC/assets/wallpapers/windows-bloom.jpg" \
    "$HOME/.local/share/backgrounds/windows-bloom.jpg"
install -Dm644 "$SRC/assets/wallpapers/MacTahoe-night.jpeg" \
    "$HOME/.local/share/backgrounds/MacTahoe-night.jpeg"

echo "== Installing GTK4 macOS stylesheet =="
install -Dm644 "$SRC/assets/gtk/gtk-macos.css" "$HOME/.config/gtk-4.0/gtk-macos.css"

echo "== Installing dock stylesheet =="
D2D="$HOME/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com"
if [ -d "$D2D" ]; then
    install -Dm644 "$SRC/assets/css/dash-to-dock.css" "$D2D/stylesheet.css"
else
    echo "  ! Dash to Dock not installed — skipping its stylesheet."
fi

echo "== Installing fastfetch config =="
install -Dm644 "$SRC/assets/fastfetch/config.jsonc" "$HOME/.config/fastfetch/config.jsonc"

echo "== Installing hidden autostart overrides =="
mkdir -p "$HOME/.config/autostart"
for f in "$SRC"/assets/autostart/*.desktop; do
    install -m644 "$f" "$HOME/.config/autostart/$(basename "$f")"
done

echo "== Patching Dash to Panel disable() (if present) =="
DTP="$HOME/.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/extension.js"
if [ -f "$DTP" ]; then
    if grep -q "panelManager.disable()" "$DTP"; then
        sed -i 's/panelManager\.disable()/panelManager?.disable()/' "$DTP"
        echo "  patched"
    else
        echo "  already patched or pattern not found"
    fi
else
    echo "  ! Dash to Panel not installed — skipping patch."
fi

echo
echo "Done. Log out and back in once so GNOME Shell reloads extensions."
echo "Then install GameBoost from https://github.com/grantdong1-maker/gameboost"
