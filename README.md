# Hyprland config (Lua)

Files:

- `hyprland.lua` — main config (binds, rules, autostart, cheat sheet at bottom)
- `hyprpaper.conf` — wallpaper config
- `wallpaper.jpg` — wallpaper
- `stt.sh` — voice-to-text toggle script (SUPER + SHIFT + D)

## Install

One command for everything this config uses:

```sh
sudo pacman -S hyprpaper waybar mako hyprpolkitagent hyprsunset wl-clipboard cliphist \
  kitty nemo rofi hyprshot grim slurp jq wireplumber brightnessctl \
  playerctl whisper-cpp wtype libnotify
```

Optional:

- Cursor theme `Bibata-Modern-Ice` (must match `hyprland.lua` env exactly), or edit the
  `XCURSOR_THEME` / `HYPRCURSOR_THEME` lines to a theme you have.
- `hyprshutdown` for the graphical exit menu (SUPER + M falls back to plain exit without it).

## Voice to text (SUPER + SHIFT + D)

Press once, speak, press again. Text types itself into the focused window
(terminal, opencode, browser). Mako shows `listening…` / `typed.` toasts.

One-time setup (after the pacman line above):

```sh
sudo pacman -S whisper-cpp wtype libnotify
mkdir -p ~/.cache/whisper
curl -L -o ~/.cache/whisper/ggml-base.en.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
hyprctl reload
```

Model is free (MIT), offline, no account. `base.en` is the speed/accuracy
sweet spot; swap in a bigger `ggml-*.bin` if you want better accuracy.

## Dark mode

Default. Applied on every login via `gsettings` autostart + `GTK_THEME` env.
Needs `gsettings-desktop-schemas` (schema) + `glib2` (binary, always present):

```sh
sudo pacman -S gsettings-desktop-schemas
```

Re-apply by hand:

```sh
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

## Everyday commands

```sh
hyprctl reload          # apply edits
hyprctl binds           # live binds (source of truth)
hyprctl configerrors    # what a broken edit complained about
```

Full keybind list lives at the bottom of `hyprland.lua` (SUPER = Windows key).
Screenshots land in `~/Pictures/ScreenShots`.
