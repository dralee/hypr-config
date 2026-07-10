-- custom window rules

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})



-- ###################### opacity ######################
hl.window_rule({
    name = "syncfullscreen网易",
    match = {
        fullscreen = true,
        initial_class = "网易云音乐"
    }
})
hl.window_rule({
    name = "code opacity rule",
    opacity = "0.9 0.95 0.9",
    match = { 
        initial_class = "(Code|code)",
        initial_title = "Visual Studio Code"
    }
})
hl.window_rule({
    name = "code opacity rule",
    opacity = "0.9 0.95 0.9",
    match = {
        initial_title = "Visual Studio Code"
    }
})
hl.window_rule({
    name = "jetbrains opacity rule",
    opacity = "0.8 0.85 0.8",
    match = { initial_class = "(jetbrains-rider|jetbrains-goland|jetbrains-rustrover|jetbrains-studio|jetbrains-gateway)"}
})
hl.window_rule({
    name = "running devices opacity",
    opacity = "1.0 1.0 1.0",
    match = { 
        initial_class = "(jetbrains-studio)",
        title = "(Running Devices*)"
    }
})
hl.window_rule({
    name = "idea opacity",
    opacity = "0.9 0.95 0.9",
    match = {
        initial_class = "jetbrains-idea"
    }
})
hl.window_rule({
    name = "datagrip opacity",
    opacity = "0.9 0.95 0.9",
    match = {
        initial_class = "jetbrains-datagrip"
    }
})
hl.window_rule({
    name = "pcmanfm opacity",
    opacity = "0.9 0.95 0.9",
    match = {
        initial_class = "pcmanfm"
    }
})
hl.window_rule({
    name = "RedisInsight opacity",
    opacity = "0.9 0.95 0.9",
    match = {
        initial_class = "Redis Insight"
    }
})
hl.window_rule({
    name = "Postman opacity",
    opacity = "0.9 0.95 0.9",
    match = {
        initial_class = "Postman"
    }
})
hl.window_rule({
    name = "Feishu 微信 opacity",
    opacity = "1.0 override 1.0 override",
    match = { initial_title = "(Feishu|微信)"}
})

-- ###################### float setting ######################
hl.window_rule({
    name = "Navicat float",
    tile = true,
    match = {initial_title = "Navicat Premium"}   --navicat.exe
})
hl.window_rule({
    name = "WeChat float",
    float = true,
    match = {
        initial_class = "wechat",
        initial_title = "(Photos and Videos|Chat History for Saved Groups|WeChat|)"
    }
})
hl.window_rule({
    name = "预览",
    float = true,
    match = {initial_title = "(预览)"}
})
hl.window_rule({
    name = "wechat tile",
    tile = true,
    match = {
        initial_class = "wechat",
        initial_title = "Weixin"
    }
})
hl.window_rule({
    name = "qq setting",
    float = true,
    match = {
        initial_class = "QQ",
        initial_title = "(收藏|设置|文件管理器|无标题|QQ邮箱提醒|图片查看器)"
    }
})
hl.window_rule({
    name = "drawing",
    float = true,
    match = {initial_class = "com.github.maoschanz.drawing"}
})
hl.window_rule({
    name = "qalculate",
    float = true,
    match = {initial_class = "qalculate"}
})
hl.window_rule({
    name = "gwenview",
    float = true,
    match = {initial_class = "org.kde.gwenview" }
})
hl.window_rule({
    name = "网易云音乐",
    tile = true,
    match = {initial_title = "网易云音乐" }
})
hl.window_rule({
    name = "Picture",
    float = true,
    match = {initial_title = "Picture" }
})
hl.window_rule({
    name = "extension",
    float = true,
    match = {initial_title = "_crx_iahnhfdhidomcpggpaimmmahffihkfnj" }
})
hl.window_rule({
    name = "dralee tools",
    float = true,
    match = {initial_class = "org.dralee.*"}
})
hl.window_rule({
    name = "pcmanfm",
    float = true,
    match = {initial_class = "(pcmanfm|Pcmanfm)" }
})
hl.window_rule({
    name = "DevTools",
    float = true,
    match = {initial_title = "DevTools" }
})
hl.window_rule({
    name = "feathernotes",
    float = true,
    match = {initial_class = "feathernotes" }
})
hl.window_rule({
    name = "feh",
    float = true,
	center = true,
    match = {initial_class = "feh" }
})
hl.window_rule({
    name = "libreoffice",
    float = true,
    match = {initial_class = "libreoffice*" }
})
hl.window_rule({
    name = "Typora",
    tile = true,
    match = {
        initial_class = "Typora",
        initial_title = "^(Typora)$"
    }
})
hl.window_rule({
    name = "Typora other",
    float = true,
    center = true,
    match = {
        initial_class = "Typora",
        initial_title = "^()$"
    }    
})
hl.window_rule({
    name = "typora temp",
    float = true,
    match = {
        initial_class = "Typora",
        title = "^(temp*)$"
    }
})
hl.window_rule({
    name = "Zettlr reference",
    float = true,
    match = {
        initial_class = "Zettlr",
        title = "^()$"
    }
})
hl.window_rule({
    name = "telegram",
    float = true,
    match = {
        initial_class = "org.telegram.desktop",
        initial_title = "^(Media viewer)$"
    }
})
hl.window_rule({
    name = "mpv",
    float = true,
    match = {initial_class = "(mpv|vlc)" }
})
hl.window_rule({
    name = "fcitx config",
    float = true,
    match = {initial_class = "(org.fcitx.fcitx5-config-qt)" }
})
hl.window_rule({
    name = "Feishu other",
    float = true,
    match = {
        initial_class = "(Feishu)",
        initial_title = "^()$"
    }
})
hl.window_rule({
    name = "nwg look",
    float = true,
    match = {
        initial_class = "(nwg-look|qt6ct|flameshot)"
    }
})
hl.window_rule({
    name = "jetbrains Merge",
    float = true,
    match = {
        initial_class = "(jetbrains*)",
        initial_title = "^(Merge Revisions*)$"
    }
})
hl.window_rule({
    name = "custom py",
    float = true,
    match = {
        initial_class = "(main.py|ccolor|Tk)"
    }
})
hl.window_rule({
    name = "lee custom gtk",
    float = true,
    match = {
        initial_class = "^(org.gtk.*|GTK Application|org.example.*|org.lee.*)$"
    }
})
hl.window_rule({
    name = "other1",
    float = true,
    match = {
        initial_class = "(clash-verge|libreoffice-startcenter|libreoffice-calc)"
    }
})
hl.window_rule({
    name = "qemu",
    float = true,
    match = {
        initial_class = "(microsoft-edge|google-chrome)",
        title = "(QEMU*|VM*)"
    }
})
hl.window_rule({
    name = "nm connection editor",
    float = true,
    match = {
        initial_class = "(nm-connection-editor)"
    }
})
hl.window_rule({
    name = "ILSp",
    float = true,
    match = {
        initial_class = "(ILSp|gucharmap)"
    }
})
hl.window_rule({
    name = "Remmina",
    float = true,
    match = {
        initial_class = "(org.remmina.Remmina|camunda-modeler)"
    }
})
hl.window_rule({
    name = "running devices android",
    float = true,
    match = {
        initial_class = "(jetbrains-studio)",
        title = "(Running Devices - DemoApp)"
    }
})
hl.window_rule({
    name = "rider Commit",
    float = true,
    match = {
        initial_class = "jetbrains-rider",
        title = "Commit:.*"
    }
})
hl.window_rule({
    name = "gateway Commit",
    float = true,
    match = {
        class = "^(jetbrains-gateway)$",
        title = "^(Commit:.*)$"
    }
})
hl.window_rule({
    name = "baidunetdisk",
    float = true,
    match = {
        initial_class = "(baidunetdisk|org.gnome.Evince)"
    }
})


-- dialog
hl.window_rule({
    name = "Open File center",
    center = true,
    float = true,
    match = { title = "^(Open File)(.*)$" }
})
hl.window_rule({
    name = "Select a File",
    center = true,
    float = true,
    match = { title = "^(Select a File)(.*)$" }
})
hl.window_rule({
    name = "Choose wallpaper",
    center = true,
    float = true,
    match = { title = "^(Choose wallpaper)(.*)$" }
})
hl.window_rule({
    name = "Open Folder",
    center = true,
    float = true,
    match = { title = "^(Open Folder)(.*)$" }
})
hl.window_rule({
    name = "Save",
    center = true,
    float = true,
    match = { title = "^(Save|Save As)(.*)$" }
})
hl.window_rule({
    name = "Library",
    center = true,
    float = true,
    match = { title = "^(Library)(.*)$" }
})
hl.window_rule({
    name = "File Upload",
    center = true,
    float = true,
    match = { title = "^(File Upload)(.*)$" }
})
hl.window_rule({
    name = "xdg-desktop-portal",
    float = true,
    match = { class = "^(xdg-desktop-portal.*)$" }
})
hl.window_rule({
    name = "chrome-naepdomgkenhinolocfifgehidddafch-Default",
    float = true,
    match = {
        class = "^(chrome-naepdomgkenhinolocfifgehidddafch-Default|msedge-_naepdomgkenhinolocfifgehidddafch-Default)$"
    }
})
hl.window_rule({
	name = "virt-manager",
    float = true,
	match = { initial_class = "(virt-manager)" }
})

hl.window_rule({
    name = "flameshot-multi-display-fix",
    animation = "fade",
    rounding = 0,
    border_size = 0,
    fullscreen_state = "0 0",
    float = true,
    pin = true,
    monitor = "HDMI-A-4",
    move = "0 0",
    size = "(monitor_w*2) (monitor_h)",
    match = { class = "flameshot" }
})
-- set this to your leftmost monitor id, otherwise you have to move your cursor to the leftmost monitor
-- before executing flameshot



