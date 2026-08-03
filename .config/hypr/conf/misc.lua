----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
	    allow_session_lock_restore = true
    },
})

-- 禁用 XWayland 窗口的硬缩放，防止截图坐标偏移
hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})