-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/configuring/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/configuring/core/monitors/
hl.monitor({
  output   = "eDP-1",
  mode     = "1920x1080@120",
  position = "0x0",
  scale    = "1.2",
})

-- Autostart wallpaper, status bar, notification daemon and clipboard history
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("waybar")
  hl.exec_cmd("mako")
  -- Clipboard history daemon: every clipboard change gets appended to cliphist's db,
  -- so the SUPER + V picker has something to show. Long-running, so its own call.
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal      = "kitty"
local fileManager   = "nemo"
local menu          = "rofi -show drun"

-- Screenshot folder (hyprshot creates it with mkdir -p if missing)
local screenshotDir = "/home/person/Pictures/ScreenShots"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/configuring/core/environment-variables/

-- Cursor theme name must match the directory in /usr/share/icons exactly:
-- "Bibata-Modern-Ice", NOT "Bibata-Modern_ice". Hyprland's own cursor reads
-- HYPRCURSOR_THEME, XWayland / GTK apps read XCURSOR_THEME. Size must match
-- org.gnome.desktop.interface cursor-size, else GTK apps disagree with us.
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/configuring/core/advanced-configuration/permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/configuring/core/config-options/
hl.config({
  general = {
    gaps_in          = 5,
    gaps_out         = 20,

    border_size      = 1,

    col              = {
      active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false,

    -- Please see https://wiki.hypr.land/configuring/extra/tearing/ before you turn this on
    allow_tearing    = false,

    layout           = "dwindle",
  },

  decoration = {
    rounding         = 4,
    rounding_power   = 2,

    -- Change transparency of focused and unfocused windows
    active_opacity   = 1.0,
    inactive_opacity = 0.8,

    shadow           = {
      enabled      = true,
      range        = 4,
      render_power = 3,
      color        = 0xee1a1a1a,
    },

    blur             = {
      enabled  = false,
      size     = 3,
      passes   = 1,
      vibrancy = 0.1696,
    },
  },

  animations = {
    enabled = true,

    -- Keep this OFF (default). Turning it on makes Hyprland XOR the slide
    -- direction whenever a switch happens between the lowest and highest
    -- existing workspaces (very common: ws 1 <-> ws 2), which reverses the
    -- animation - workspace 2 would slide in from the LEFT instead of the
    -- right. Off = natural order: 1 -> 2 slides left (2 enters from the
    -- right), 2 -> 1 slides right (1 enters from the left).
    -- workspace_wraparound = false,
  },
})

-- Default curves and animations, see https://wiki.hypr.land/configuring/core/animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, spring = "easy" })
-- Fast slide in / out when windows open and close
hl.animation({ leaf = "windowsIn", enabled = true, speed = 2.5, bezier = "quick", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "quick", style = "slide" })
-- Fade matched to the slide so windows don't vanish mid-flight
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
-- Fast slide when switching between workspaces (special workspaces inherit this)
hl.animation({ leaf = "workspaces", enabled = true, speed = 2.5, bezier = "quick", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2.5, bezier = "quick", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.5, bezier = "quick", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Ref https://wiki.hypr.land/configuring/core/rules/workspace-rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/configuring/layouts/dwindle-layout/ for more
hl.config({
  dwindle = {
    preserve_split = true, -- You probably want this
  },
})

-- See https://wiki.hypr.land/configuring/layouts/master-layout/ for more
hl.config({
  master = {
    new_status = "master",
  },
})

-- See https://wiki.hypr.land/configuring/layouts/scrolling-layout/ for more
hl.config({
  scrolling = {
    fullscreen_on_one_column = true,
  },
})

----------------
----  MISC  ----
----------------

hl.config({
  misc = {
    -- No built-in background from Hyprland: no bundled wall*.png, no anime
    -- mascot. Hyprland just clears to misc.background_color until hyprpaper
    -- paints over it. force_default_wallpaper is gone because it is ignored
    -- while this flag is true.
    disable_hyprland_logo    = true,
    -- Hyprland also renders a random splash line at the bottom (the "- vaxry"
    -- one comes from there). Off: nothing is drawn on startup.
    disable_splash_rendering = true,
  },
})


---------------
---- INPUT ----
---------------

hl.config({
  input = {
    kb_layout    = "us",
    kb_variant   = "",
    kb_model     = "",
    kb_options   = "",
    kb_rules     = "",

    follow_mouse = 1,

    sensitivity  = 0, -- -1.0 - 1.0, 0 means no modification.

    touchpad     = {
      natural_scroll = false,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/configuring/core/devices/ for more
hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/configuring/core/binds/ for more

-- Open the terminal ("RETURN" is the xkb keysym name for Enter)
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))

-- Close / kill the focused window
hl.bind(mainMod .. " + Q", hl.dsp.window.close())        -- close gracefully (asks the app to quit)
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill()) -- force kill (SIGKILL)

local closeWindowBind = hl.bind(mainMod .. " + C", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
-- Clipboard history: list entries in rofi, copy the picked one back with wl-copy.
-- SUPER + V used to toggle float, that moved to SUPER + SHIFT + V below, nothing lost.
-- "sel=$(...)" keeps rofi's cancel (no output) out of wl-copy: an empty "cliphist decode"
-- would otherwise wipe the very clipboard you opened the picker for.
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(
  "sel=$(cliphist list | rofi -dmenu); [ -n \"$sel\" ] && printf \"%s\\n\" \"$sel\" | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- App launcher on mainMod + SPACE (rofi drun, icons on via ~/.config/rofi/config.rasi)
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

-- mainMod + SHIFT + SPACE: rofi "run" mode, type any command and run it
-- ("run" is in rofi's default mode list; -no-show-icons because run mode has
--  no icon names to resolve and show-icons is on globally in config.rasi)
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("rofi -show run -no-show-icons"))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- Fullscreen
-- mainMod + F toggles fullscreen of the focused window
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
-- mainMod + SHIFT + F always leaves fullscreen, no matter how the window got there
-- (internal = 0 / client = 0 clears internal fullscreen + maximize and app-requested
--  fullscreen, e.g. a video player or browser F11)
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 0, action = "set" }))

-- togglesplit moved off mainMod + J, since J is now the vim "focus down" bind
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only

-- Vim-style focus: mainMod + h/j/k/l
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Vim-style move window: mainMod + SHIFT + h/j/k/l
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Move focus with mainMod + arrow keys (aliases of the vim binds above)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- LCD brightness from the keyboard as well (requires brightnessctl):
-- mainMod + SHIFT + B increases, mainMod + B decreases.
-- Same command/flags as the XF86MonBrightness* keys above, and "repeating" makes
-- holding the key ramp the brightness instead of only stepping once.
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
  { locked = true, repeating = true })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })


----------------------
---- SCREENSHOTS -----
----------------------

-- Needs hyprshot + grim + slurp + jq + wl-clipboard (plus mako for the "saved" toast).
-- Mode triples used below (hyprshot only needs slurp for the region/plain-output modes):
--   -m active -m output  whole current monitor, geometry from hyprctl, no mouse click
--   -m window -m active  focused window, geometry from hyprctl, no mouse click
--   -m region            slurp area pick (needs your mouse)
-- Plain "-m output" alone would instead make you click a monitor with slurp.
-- hyprshot always runs wl-copy too, so every saving bind does file + clipboard.
local stamp    = "$(date +%Y-%m-%d_%H-%M-%S)"
local saveOpts = " -o " .. screenshotDir .. " -f \"" .. stamp .. "-"

-- Print: whole screen -> file + clipboard
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m active -m output" .. saveOpts .. "full.png\""))

-- SUPER + Print: active window -> file + clipboard
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window -m active" .. saveOpts .. "window.png\""))

-- SHIFT + Print: selected region -> file + clipboard
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region" .. saveOpts .. "select.png\""))

-- CTRL + Print: whole screen -> clipboard only, no file
hl.bind("CTRL + Print", hl.dsp.exec_cmd("hyprshot -m active -m output --clipboard-only"))

-- CTRL + SUPER + Print: active window -> clipboard only, no file
hl.bind("CTRL + " .. mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m window -m active --clipboard-only"))

-- CTRL + SHIFT + Print: selected region -> clipboard only, no file
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/configuring/core/rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})


-- ==========================================================================
--              HYPRLAND KEYBINDINGS - CHEAT SHEET (read me first)
-- ==========================================================================
--
-- SUPER = the Windows key. In this file: mainMod = "SUPER".
-- Every bind reads:  hl.bind("<MODS> + <KEY>", hl.dsp.<action>(...), { opts })
--   - " + " joins modifiers and the key, all uppercase. Order does not matter.
--   - Key names are xkb keysyms: RETURN = Enter, SPACE = space, Print = PrtSc,
--     left / right / up / down = arrow keys, mouse_down / mouse_up = scroll wheel,
--     mouse:272 = left mouse button, mouse:273 = right mouse button.
--   - { locked = true }      = also works on the lock screen, { repeating = true } = keeps firing
--     while the key is held.
-- Handy commands:
--   hyprctl reload                     apply edits in this file
--   hyprctl binds                      show every live bind (source of truth)
--   hyprctl configerrors               show what a broken edit complained about
--   hyprctl binds -j | jq -r '.[] | "\(.modmask) \(.key)"'   compact list
--
-- --------------------------------------------------------------------------
-- LAUNCHERS AND PROGRAMS
-- --------------------------------------------------------------------------
-- SUPER + RETURN          open terminal (kitty)
-- SUPER + E               open file manager (nemo)
-- SUPER + R               app launcher: rofi drun, with icons
-- SUPER + SPACE           app launcher: rofi drun (same thing, easier to reach)
-- SUPER + SHIFT + SPACE   run-command launcher: rofi "run" mode, type any command
-- SUPER + M               exit menu: hyprshutdown if installed, else leave Hyprland
--
-- --------------------------------------------------------------------------
-- WINDOWS
-- --------------------------------------------------------------------------
-- SUPER + Q               close focused window politely (app may ask to save)
-- SUPER + SHIFT + Q       kill focused window dead (SIGKILL, no prompt)
-- SUPER + C               close focused window (same as SUPER + Q)
-- SUPER + V               clipboard history picker (rofi + cliphist, see CLIPBOARD below)
-- SUPER + SHIFT + V       toggle floating / tiled (moved off SUPER + V for the picker)
-- SUPER + P               toggle pseudo-tile (dwindle: the window keeps half the split)
-- SUPER + F               toggle fullscreen
-- SUPER + SHIFT + F       force leave fullscreen (clears app-requested fullscreen too, e.g. F11)
-- SUPER + T               toggle split direction (dwindle layout only)
-- SUPER + LMB drag        move window with the mouse
-- SUPER + RMB drag        resize window with the mouse
--
-- --------------------------------------------------------------------------
-- FOCUS  (vim keys and arrow keys do exactly the same)
-- --------------------------------------------------------------------------
-- SUPER + H  or  LEFT     focus window on the left
-- SUPER + J  or  DOWN     focus window below
-- SUPER + K  or  UP       focus window above
-- SUPER + L  or  RIGHT    focus window on the right
--
-- --------------------------------------------------------------------------
-- MOVE WINDOW (same four keys as focus, with SHIFT added)
-- --------------------------------------------------------------------------
-- SUPER + SHIFT + H       move window left
-- SUPER + SHIFT + J       move window down
-- SUPER + SHIFT + K       move window up
-- SUPER + SHIFT + L       move window right
--
-- --------------------------------------------------------------------------
-- WORKSPACES (1 .. 10; the "0" key is workspace 10)
-- --------------------------------------------------------------------------
-- SUPER + 1 .. 0          switch to workspace 1 .. 10
-- SUPER + SHIFT + 1 .. 0  send focused window to workspace 1 .. 10
-- SUPER + mouse_down      next existing workspace  (e+1)
-- SUPER + mouse_up        previous existing workspace  (e-1)
-- 3-finger swipe sideways switch workspace (touchpad gesture, hl.gesture)
--
-- --------------------------------------------------------------------------
-- SPECIAL WORKSPACE "magic" (scratchpad - never shown in the normal strip)
-- --------------------------------------------------------------------------
-- SUPER + S               show / hide the magic scratchpad
-- SUPER + SHIFT + S       move focused window into special:magic

--
-- --------------------------------------------------------------------------
-- CLIPBOARD HISTORY  (cliphist daemon + rofi dmenu + wl-copy)
-- --------------------------------------------------------------------------
-- SUPER + V               pick an old copy in rofi, the pick is copied back to the clipboard
-- The history is fed by the "wl-paste --watch cliphist store" autostart at the top of
-- this file; without that daemon the picker stays empty until something is copied.
-- Cancel in rofi (ESC) leaves the clipboard untouched (that is what the [ -n "$sel" ]
-- guard in the bind is for). "cliphist list" prints "id<TAB>preview", and the whole
-- line - not just the id - is what "cliphist decode" expects.
-- cliphist stores images too, so picking an image from history copies the image.
-- Maintenance:  cliphist list | cliphist wipe | cliphist status
-- (db lives in ~/.cache/cliphist)
--
-- --------------------------------------------------------------------------
-- SCREENSHOTS  (hyprshot + grim + slurp + jq + wl-clipboard; mako shows the toast)
-- Files land in /home/person/Pictures/ScreenShots as <date>_<time>-<kind>.png
-- hyprshot runs wl-copy as well, so every "file" bind gives you file + clipboard.
-- Mode flags used: "-m active -m output" = whole monitor, "-m window -m active" =
-- focused window (both read geometry from hyprctl, no mouse click needed),
-- "-m region" = draw a box with slurp. "--clipboard-only" = no file written.
-- --------------------------------------------------------------------------
-- Print                   whole screen   -> file + clipboard
-- SUPER + Print           focused window -> file + clipboard
-- SHIFT + Print           pick region    -> file + clipboard
-- CTRL + Print            whole screen   -> clipboard only, no file
-- CTRL + SUPER + Print    focused window -> clipboard only, no file
-- CTRL + SHIFT + Print    pick region    -> clipboard only, no file
-- The folder comes from the screenshotDir local near "MY PROGRAMS".
-- If Print does nothing at all: a 61-key board may never send the Print keysym.
-- Check with:  wev   (press the key, read the "keysym" line, bind that name instead)
--
-- --------------------------------------------------------------------------
-- VOLUME / MIC / BRIGHTNESS / MEDIA  (hardware keys; volume+brightness are locked)
-- --------------------------------------------------------------------------
-- Volume Up               sink volume +5%  (wpctl, capped at 100%)
-- Volume Down             sink volume -5%
-- Volume Mute             mute / unmute speakers
-- Mic Mute                mute / unmute microphone
-- Brightness Up           LCD brightness +5%  (brightnessctl)
-- Brightness Down         LCD brightness -5%
-- SUPER + SHIFT + B       LCD brightness +5%  (keyboard shortcut for Brightness Up)
-- SUPER + B               LCD brightness -5%
-- Next / Previous         playerctl next / previous track
-- Play / Pause            playerctl play-pause  (both keys mapped to the same action)
-- All of the above repeat while the key is held down.
--
-- --------------------------------------------------------------------------
-- ADDING YOUR OWN BIND (copy - paste one of these lines)
-- --------------------------------------------------------------------------
-- hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("some-app"))            -- run a program
-- hl.bind(mainMod .. " + X", hl.dsp.window.close())                  -- a window action
-- hl.bind("XF86SomeKey", hl.dsp.exec_cmd("cmd"), { locked = true, repeating = true })
-- Then run:  hyprctl reload      broken syntax = the old config keeps running,
-- so check `hyprctl configerrors` right after the reload.
