-- 支持播放列表在关闭后，下一次启动时，自动继续播放上次的文件
-- 2025.4.1 by dralee
-- 2025.4.3 by dralee support playlist time pos
local home = os.getenv("HOME")
local playlist_pos_file = "/tmp/mpv_playlist_pos" -- 记录播放进度的文件

-- 加载luajit版本(即lua5.1)版本的库
package.cpath = package.cpath ..
                    string.format(";%s/.luarocks/lib/lua/5.1/?.so", home)

local mp = require("mp")
local cjson = require("cjson") -- luarocks install lua-cjson
local md5 = dofile(string.format("%s/.config/mpv/scripts/md5.lua", home))
local last_time_pos = -1 -- 最新的播放进度
local restore_time_pos = 0 -- 恢复的播放进度
local restore_pos = 0 -- 恢复的播放项

-- 实时保存当前播放进度
mp.observe_property("time-pos", "number", function(_, value)
    if value then last_time_pos = value end
end)
-- 文件加载完毕事件
mp.register_event("file-loaded", function()
    local pos = mp.get_property_number("playlist-pos", 0)
    -- print("the pos is", pos, "restore-pos", restore_pos)
    if restore_time_pos > 0 and pos == restore_pos then
        mp.set_property_number("time-pos", restore_time_pos)
        mp.osd_message(string.format("文件已加载，跳转到%d秒",
                                     restore_time_pos))
        restore_time_pos = 0 -- 清除
        restore_pos = 0
    end
end)
-- 监听重新加载文件
-- mp.register_event("playback-restart", function()
--	mp.osd_message(string.format("跳转到%d秒",time_pos))
--	mp.set_property_number("time-pos", last_time_pos)
-- end)

-- 退出时记录播放位置
mp.register_event("shutdown", function()
    local pos = mp.get_property_number("playlist-pos", -1)
    print("time pos", last_time_pos)
    -- local playlist = mp.get_property("playlist")
    playlist_pos_file_real = current_playlist_pos_file()
    local file = io.open(playlist_pos_file_real, "w")
    if file then
        line = format_data(pos, last_time_pos)
        file:write(line)
        file:close()
    end
end)

-- 启动时恢复播放位置
mp.register_event("start-file", function()
    -- print("start a file")
    -- hello()
    playlist_name_arg()
    playlist_pos_file_real = current_playlist_pos_file()

    local file = io.open(playlist_pos_file_real, "r")
    if file then
        local line = file:read("*all")
        file:close()
        os.remove(playlist_pos_file_real) -- 删除原来的文件,以待退出重新写入
        local data = parse_data(line)
        print("line:", line, "data:", cjson.encode(data))
        if data then
            local pos = tonumber(data[1]) -- tonumber(file:read("*all"))
            local time_pos = tonumber(data[2])
            print("pos:", pos, "time:", time_pos)
            if pos and pos > 0 then
                restore_pos = pos
                mp.set_property("playlist-pos", pos)
            end
            if time_pos and time_pos > 0 then
                -- 刚打开文件，设置不生效，使用playback-restart进行设置
                -- mp.set_property_number("time-pos", time_pos)
                -- mp.commandv("seek", time_pos, "absolute") -- time-pos失效，使用seek
                restore_time_pos = time_pos
            end
        end
    end
end)

-- 封装格式
function format_data(pos, time_pos)
    line = string.format("%d:%d", pos, time_pos)
    return line
end

-- 解析格式
function parse_data(data)
    if data then return split(data, ':') end
    return nil
end

-- 当前播放列表对应存储位置
function current_playlist_pos_file()
    local playlist_name = palylist_filename()
    local key = md5.sumhexa(playlist_name)
    print("the playlist is " .. playlist_name .. ",key:" .. key)
    latest_playlist_pos_file = playlist_pos_file .. "_" .. key
    return latest_playlist_pos_file
end

-- 获取播放列表名称
function palylist_filename()
    local playlist = mp.get_property("playlist")
    local data = cjson.decode(playlist)
    if data then return data[1]["playlist-path"] end
    return nil
end

-- 需要通过参数: --script-opts=playlist_file=xxxx.m3u参数进行传递真实播放列表
-- 此方式验证无效
function playlist_name_arg()
    local options = require("mp.options")
    local o = {playlist_file = ""}
    options.read_options(o)

    if o.playlist_file ~= "" then
        local msg = "当前播放列表:" .. o.playlist_file
        mp.osd_message(msg)
        print(msg)
    end

end

-- 不一定准确
-- 无效
function playlist_name()
    local playlist_count = mp.get_property_number("playlist-count", 0)
    if playlist_count > 1 then
        local filename = mp.get_property("stream-open-filename") -- 可能不准确
        local msg = "当前播放列表:" .. (filename or "未知")
        print(msg)
        mp.osd_message(msg)
    end
end

-- 分隔字符串
function split(inputstr, sep)
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function hello() print("hello world") end
