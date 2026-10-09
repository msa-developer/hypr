#!/bin/sh
# Toggle voice-to-text: press bind once to record, again to transcribe + type.
# Needs: whisper-cpp, wtype, pw-record (pipewire). Model: ~/.cache/whisper/ggml-base.en.bin
PIDF=/tmp/hypr-stt.pid
WAV=/tmp/hypr-stt.wav
MODEL="$HOME/.cache/whisper/ggml-base.en.bin"

if [ -f "$PIDF" ]; then
  kill "$(cat "$PIDF")" 2>/dev/null
  rm -f "$PIDF"
  [ -f "$MODEL" ] || { notify-send "STT" "missing model $MODEL"; exit 1; }
  notify-send "STT" "transcribing…"
  whisper-cpp -m "$MODEL" -f "$WAV" -otxt -of /tmp/hypr-stt 2>/dev/null
  tr '\n' ' ' < /tmp/hypr-stt.txt | wtype -
  notify-send "STT" "typed."
else
  pw-record --rate 16000 --channels 1 "$WAV" &
  echo $! > "$PIDF"
  notify-send "STT" "listening… press again to stop"
fi
