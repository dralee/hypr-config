-- custom window place in workspaces

-- place on workspace
hl.window_rule({
    name = "workspace2",
    workspace = 2,
    match = {
        initial_class = "jetbrains-rider",
        initial_title = "(Welcome to JetBrains Rider)"
    }
})
--hl.window_rule({workspace 3, match = {initial_class = google-chrome
hl.window_rule({
    name = "workspace4",
    workspace = 4,
    match = {
        initial_class = "(code|Code|code-url-handler)"
    }
})
hl.window_rule({
    name = "workspace5",
    workspace = 5,
    match = {
        initial_class = "(jetbrains-idea|spotify|org.telegram.desktop|jetbrains-goland|jetbrains-rustrover|jetbrains-studio|firefox|jetbrains-gateway)"
    }
})
hl.window_rule({
    name = "workspace7",
    workspace = 7,
    match = {
        initial_class = "jetbrains-datagrip"
    }
})
hl.window_rule({
    name = "workspace6",
    workspace = 6,
    match = {
        initial_class = "(Feishu|QQ|wechat|Typora)",
    }
})
hl.window_rule({
    name = "workspace8",
    workspace = 8,
    match = {
        initial_class = "(microsoft-edge)",
        class = "(microsoft-edge)"
    }
})
hl.window_rule({
    name = "workspace9",
    workspace = 9,
    match = {
        initial_class = "(Postman|Redis Insight|RedisInsight)"
    }
})
--hl.window_rule({workspace 10, match = {title = (*Opera)
hl.window_rule({
    name = "workspace10",
    workspace = 10,
    match = {
        initial_class = "(google-chrome)"
    }
})