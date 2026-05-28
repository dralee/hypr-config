-- environment for default
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "MacOS-Pixel-vr3")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")  -- change to qt6ct if you have that

-- XDG
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- electron
hl.env("ELECTRON_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

-- Qt
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
--hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- Wayland variables
hl.env("OZONE_PLATFORM", "wayland")
hl.env("DESKTOP_SESSION", "Hyprland")

-- GDK
hl.env("GDK_SCALE", "1")

-- Toolkit Backend
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- Mozilla
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- SDL version
hl.env("SDL_VIDEODRIVER", "wayland")

-- Quickshell debug
hl.env("QS_NO_RELOAD_POPUP", "1")


-- input method
hl.env("QT_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULES", "wayland;fcitx;ibus")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")
hl.env("INPUT_METHOD", "fcitx")
hl.env("XMODIFIERS", "fcitx")
hl.env("IMSETTINGS_MODULE", "fcitx")

-- for waybar env
-- custom/weather2 shenzhen location id
hl.env("location_id", "4945e1616a82b28a995f412bf561340d96d0d1941d2980e107c9fd4bf73be75e")
