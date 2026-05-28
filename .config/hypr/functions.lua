-- Load Config file, conf/...lua
-- 2026.5.28 by dralee

-- 运行环境变量
HYPR_RUN_PC_ENV = {
    WORK = "work",
    HOME = "home",
    LAPTOP = "laptop",
    UNKNOWN = "unknown"
}

-- 运行环境
Hypr_run_env = HYPR_RUN_PC_ENV.UNKNOWN


-- 加载配置文件
-- @param variant_name(string) 配置名称
-- @param variant_file(string) 配置文件，不需要添加.lua后缀
-- @return 完整的配置文件路径
function Load_config(variant_name, variant_file)
    variant_file = variant_file:gsub(".lua", "")
    require("conf." .. variant_name .. "." .. variant_file)
end

-- 加载环境变量
-- @return void
local function load_env()
    local env = os.getenv("HYPR_RUN_PC_ENV") or "unknown"
    Hypr_run_env = env
    Log("run env is " .. env)
end

-- 日志
-- @param msg(string)
-- @return void
function Log(msg)
    local log = io.open("/tmp/hyprland-debug.log", "a")
    if log then
        log:write(os.date() .. ": " .. msg .. "\n")
        log:close()
    end
end

-- 加载环境变量
load_env()
