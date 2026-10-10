# Keybindings

SUPER = Windows key. Live truth: `hyprctl binds`.

## Launchers and programs

| Bind | Action |
|---|---|
| SUPER + RETURN | Terminal (kitty) |
| SUPER + E | File manager (nemo) |
| SUPER + R / SUPER + SPACE | App launcher (rofi drun) |
| SUPER + SHIFT + SPACE | Run-command launcher (rofi run mode) |
| SUPER + SHIFT + M | Exit menu (hyprshutdown, else leave Hyprland) |
| SUPER + SHIFT + D | Voice to text: press, speak, press again (types into focused window) |

## Windows

| Bind | Action |
|---|---|
| SUPER + Q / SUPER + C | Close window politely |
| SUPER + SHIFT + Q | Kill window (SIGKILL) |
| SUPER + V | Clipboard history picker (rofi + cliphist) |
| SUPER + SHIFT + V | Toggle floating / tiled |
| SUPER + P | Toggle pseudo-tile (dwindle) |
| SUPER + F | Toggle fullscreen |
| SUPER + SHIFT + F | Force leave fullscreen (also app-requested, e.g. F11) |
| SUPER + T | Toggle split direction (dwindle) |
| SUPER + left-drag / right-drag | Move / resize window with mouse |

## Focus (vim keys = arrow keys)

| Bind | Action |
|---|---|
| SUPER + H/J/K/L or arrows | Focus left / down / up / right |
| SUPER + SHIFT + H/J/K/L | Move window left / down / up / right |

## Workspaces (0 = workspace 10)

| Bind | Action |
|---|---|
| SUPER + 1..0 | Switch workspace |
| SUPER + SHIFT + 1..0 | Send window to workspace |
| SUPER + scroll down / up | Next / previous workspace |
| 3-finger horizontal swipe | Switch workspace |

## Scratchpad ("magic")

| Bind | Action |
|---|---|
| SUPER + S | Show / hide scratchpad |
| SUPER + SHIFT + S | Move window into scratchpad |

## Screenshots (files → `~/Pictures/ScreenShots`, always + clipboard)

| Bind | Action |
|---|---|
| Print | Whole screen → file |
| SUPER + Print | Focused window → file |
| SHIFT + Print | Pick region → file |
| CTRL + Print | Whole screen → clipboard only |
| CTRL + SUPER + Print | Focused window → clipboard only |
| CTRL + SHIFT + Print | Pick region → clipboard only |

No Print key on small boards? Run `wev`, press the key, bind the shown keysym.

## Volume / brightness / media (repeat while held)

| Bind | Action |
|---|---|
| Volume Up / Down / Mute, Mic Mute | PipeWire via `wpctl` |
| Brightness Up / Down, SUPER + SHIFT + B / SUPER + B | `brightnessctl` ±5% |
| SUPER + SHIFT + N | Night light on (hyprsunset 3500K) |
| Next / Previous / Play | `playerctl` |
| F1 / F2 / F3 | Mute / volume- / volume+ (external keyboards) |
| F6 / F7 | Brightness- / brightness+ (external keyboards) |

## Laptop keyboard

| Bind | Action |
|---|---|
| SUPER + U | Disable / re-enable built-in keyboard fully (incl. Fn-row F5/F6/F7, USB keyboard stays active) |

## Handy commands

```sh
hyprctl reload        # apply config edits
hyprctl binds         # live binds (source of truth)
hyprctl configerrors  # what a broken edit complained about
```

## Adding your own bind

```lua
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("some-app"))
hl.bind(mainMod .. " + X", hl.dsp.window.close())
```

Then `hyprctl reload` and check `hyprctl configerrors`.
