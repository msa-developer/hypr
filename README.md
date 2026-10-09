# Hyprland config (Lua)

Files:

- `hyprland.lua` — main config (binds, rules, autostart, cheat sheet at bottom)
- `hyprpaper.conf` — wallpaper config
- `wallpaper.jpg` — wallpaper
- `stt.sh` — voice-to-text toggle script (SUPER + SHIFT + D)
- `setup.sh` — fresh-machine bootstrap (packages + model + dark mode)

## Fresh install

Config lives in git, so no reconfiguration ever. On a new OS:

```sh
git clone https://github.com/msa-developer/hypr ~/.config/hypr
~/.config/hypr/setup.sh
```

Then log into Hyprland. Done.

## Install

One command for everything this config uses:

```sh
sudo pacman -S hyprpaper waybar mako hyprpolkitagent hyprsunset wl-clipboard cliphist \
  kitty nemo rofi hyprshot grim slurp jq wireplumber brightnessctl \
  playerctl whisper-cpp wtype libnotify \
  xdg-desktop-portal-hyprland xdg-desktop-portal-gtk pipewire-pulse adwaita-icon-theme inotify-tools wev \
  ttf-jetbrains-mono-nerd otf-font-awesome ttf-dejavu noto-fonts noto-fonts-emoji
```
AUR (via yay/paru): `bibata-cursor-theme`, `zscroll`. Optional waybar click-apps: `ghostty`, `bluetui`, `nmrs`.

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

Note: the `whisper-cpp` package installs the binary as `whisper-cli`
(`stt.sh` already calls the right name).

No text typed? You skipped the install or the model download. Fail toast
points at `/tmp/hypr-stt.err` for the exact error.

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

Full keybind list: `KEYBINDINGS.md` (SUPER = Windows key).
Screenshots land in `~/Pictures/ScreenShots`.
