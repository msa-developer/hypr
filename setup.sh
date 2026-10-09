#!/bin/sh
# Fresh-machine bootstrap. Clone repo to ~/.config/hypr, then run this once.
# Installs every package this config uses, fetches whisper model, sets dark mode.
set -e
sudo pacman -S --needed git hyprpaper waybar mako hyprpolkitagent hyprsunset \
  wl-clipboard cliphist kitty nemo rofi hyprshot grim slurp jq wireplumber \
  brightnessctl playerctl whisper-cpp wtype libnotify gsettings-desktop-schemas
mkdir -p ~/.cache/whisper ~/Pictures/ScreenShots
# App configs use the same git trick as this repo — clone, no manual setup.
[ -e ~/.config/kitty ] || git clone https://github.com/msa-developer/kitty.git ~/.config/kitty
[ -e ~/.config/waybar ] || git clone https://github.com/msa-developer/waybar ~/.config/waybar
[ -f ~/.cache/whisper/ggml-base.en.bin ] || curl -L -o ~/.cache/whisper/ggml-base.en.bin \
  https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-base.en.bin
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
echo "Done. Log into Hyprland."
