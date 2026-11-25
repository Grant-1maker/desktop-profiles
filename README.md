# Desktop profiles

Assets, stylesheets, launchers and patches that make up the **macOS / Windows / Ubuntu** desktop profiles driven by [GameBoost](https://github.com/Grant-1maker/gameboost).

## Contents

```
assets/
  launchers/   .desktop launchers (search, Windows-logo start, Microsoft Store)
  icons/       Windows logo, ArcMenu logo, Microsoft Store icon
  gtk/         Full MacTahoe GTK4 stylesheet (rounded corners, traffic lights)
  css/         Dash to Dock stylesheet + Liquid Glass managed CSS blocks
  wallpapers/  Windows Bloom + MacTahoe night
  fastfetch/   Fastfetch terminal welcome config
  autostart/   Hidden autostart overrides (Remmina, Orca, NVIDIA, etc.)
patches/
  dash-to-panel-disable.patch   Null-guard for Dash to Panel's disable()
```

## Installation

```bash
git clone https://github.com/Grant-1maker/desktop-profiles.git
cd desktop-profiles
./install.sh
```

The installer copies everything into XDG user directories (`~/.local/share`, `~/.config`). It does **not** touch GDM, `/etc`, or system packages. Log out and back in once afterwards so GNOME Shell reloads the extension code.

## Dependencies

- GNOME Shell 50 (Ubuntu 26.04)
- Extensions: Liquid Glass (`liquid-glass@thinkingcoding1231.gmail.com`), ArcMenu (`arcmenu@arcmenu.com`), Dash to Dock (`dash-to-dock@micxgx.gmail.com`), Dash to Panel (`dash-to-panel@jderose9.github.com`, v73+), Ubuntu Dock (stock)
- GTK themes: `MacTahoe-Dark`, `Yaru-dark`, `Yaru`
- Icon themes: `Win11-dark`, `Yaru-blue-dark`, `Yaru`
- `fastfetch`, Capitaine Cursors for macOS mode

## Notes

- Animated wallpaper was deliberately removed; only static wallpapers are used.
- `assets/css/liquid-glass-managed-blocks.css` documents the two CSS blocks GameBoost injects into Liquid Glass (`UBUNTU_DOCK_SQUARE` and `WINDOWS_TOPBAR_HIDE`).
- Dash to Panel settings are left entirely to the user and persist across profile switches. The patch prevents a `panelManager is null` error when leaving Windows mode.

## License / third-party assets

Scripts are MIT (`LICENSE`). Bundled wallpapers, icons and GTK themes are third-party assets (Microsoft, Apple, Yaru/Canonical) and remain the property of their respective owners.
