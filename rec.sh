#!/bin/sh
# Toggle screen record (Hyprland wiki: wf-recorder): press once start, again stop.
# File-only, audio OFF by default. SUPER+SHIFT+A toggles audio flag.
# Needs: wf-recorder, slurp (region mode only), libnotify.
PIDF=/tmp/hypr-rec.pid
OUTF=/tmp/hypr-rec.out
AUDF=/tmp/hypr-rec-audio
DIR=/home/person/videos/screen-recordings
mkdir -p "$DIR"

if [ "$1" = "audio" ]; then
  if [ -f "$AUDF" ]; then
    rm -f "$AUDF"
    notify-send "Record audio: OFF"
  else
    touch "$AUDF"
    notify-send "Record audio: ON"
  fi
  exit 0
fi

if [ -f "$PIDF" ]; then
  kill -INT "$(cat "$PIDF")" 2>/dev/null
  rm -f "$PIDF"
  OUT="$(cat "$OUTF" 2>/dev/null)"
  rm -f "$OUTF"
  notify-send "Recording saved" "${OUT:-$DIR}"
else
  OUT=$DIR/record-$(date +%Y-%m-%d_%H-%M-%S).mp4
  AUDIO=""
  [ -f "$AUDF" ] && AUDIO="--audio"
  if [ "$1" = "region" ]; then
    GEO="$(slurp)" || exit 0
    [ -z "$GEO" ] && exit 0
    # shellcheck disable=SC2086
    wf-recorder -g "$GEO" $AUDIO -f "$OUT" &
  else
    # shellcheck disable=SC2086
    wf-recorder $AUDIO -f "$OUT" &
  fi
  echo $! > "$PIDF"
  printf "%s" "$OUT" > "$OUTF"
  if [ -n "$AUDIO" ]; then
    notify-send "Recording… (audio ON)" "press again to stop"
  else
    notify-send "Recording…" "press again to stop"
  fi
fi