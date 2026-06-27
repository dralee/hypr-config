-- custom keybindings

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- start app
-- hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --disable-gpu"))
hl.bind(mainMod .. " + CTRL + B", hl.dsp.exec_cmd("microsoft-edge-stable --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime --disable-gpu"))
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.exec_cmd("pkill waybar || waybar &"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + PERIOD", hl.dsp.exec_cmd("gucharmap"))

-- shell
hl.bind("ALT + G", hl.dsp.exec_cmd("$HOME/Application/shells/z9_pro.sh"))
-- 选择剪切历史
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))
-- resize
-- Switch to a submap called `resize`.
hl.bind("ALT + SHIFT + R", hl.dsp.submap("resize"))
-- Start a submap called "resize".
hl.define_submap("resize", function()
    -- Set repeating binds for resizing the active window.
    hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true}), { repeating = true })
    hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true}), { repeating = true })
    hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true}), { repeating = true })
    hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true}), { repeating = true })
    -- Use `reset` to go back to the global submap
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- lock hyprlock
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("$HOME/.config/hypr/hyprlock.sh"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("wlogout"))
-- window
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("fullscreen"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("centerwindow"))
-- shot
-- hl.bind("CTRL + ALT + A", hl.dsp.exec_cmd("hyprshot-gui"))
hl.bind("CTRL + ALT + A", hl.dsp.exec_cmd("XDG_CURRENT_DESKTOP=sway QT_QPA_PLATFORM=wayland flameshot gui"))
hl.bind("CTRL + ALT + Q", hl.dsp.exec_cmd("hyprshot -m region -s --clipboard-only"))                        -- 只保存到剪切板
hl.bind("CTRL + ALT + E", hl.dsp.exec_cmd("hyprshot -m region -r - | swappy -f"))                           -- 编辑截图

-- record
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("notify-send \"start record\" \"recording to $HOME/Videos/record-xxxx.mp4\" && wf-recorder -g \"$(slurp)\" -f \"$HOME/Videos/record-`date +'%Y%m%d%H%M%S'`.mp4\""))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("pkill wf-recorder && notify-send \"finish\" \"record save in $HOME/Videos/record-`date +'%Y%m%d%H%M%S'`.mp4\""))

-- music
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("$HOME/.config/cmus/cmus-display.sh"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("$HOME/.config/shells/audio-switch.sh"))

-- music control
hl.bind(mainMod .. " + ALT + left", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + ALT + up", hl.dsp.exec_cmd("playerctl volume 0.1+"))
hl.bind(mainMod .. " + ALT + down", hl.dsp.exec_cmd("playerctl volume 0.1-"))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd("playerctl play-pause"))
