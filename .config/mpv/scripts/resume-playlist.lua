-- 支持播放列表在关闭后，下一次启动时，自动继续播放上次的文件
-- 2025.4.1 by dralee

local playlist_pos_file = "/tmp/mpv_playlist_pos"  -- 记录播放进度的文件

-- 加载luajit版本(即lua5.1)版本的库
package.cpath = package.cpath .. ";/home/dralee/.luarocks/lib/lua/5.1/?.so"

local mp = require("mp")
local cjson = require("cjson")   -- luarocks install lua-cjson
local md5 = dofile("/home/dralee/.config/mpv/scripts/md5.lua")


-- 退出时记录播放位置
mp.register_event("shutdown", function()
    local pos = mp.get_property_number("playlist-pos", -1)
	-- local playlist = mp.get_property("playlist")
	playlist_pos_file_real = current_playlist_pos_file()
    local file = io.open(playlist_pos_file_real, "w")
    if file then
      file:write(pos)
      file:close()
    end
  end)

-- 启动时恢复播放位置
mp.register_event("start-file", function()
	-- print("start a file")
	--hello()
	playlist_name_arg()
	playlist_pos_file_real = current_playlist_pos_file()

    local file = io.open(playlist_pos_file_real, "r")
    if file then
      local pos = tonumber(file:read("*all"))
      file:close()
      if pos and pos > 0 then
        mp.set_property("playlist-pos", pos)
		os.remove(playlist_pos_file) -- 删除原来的文件,以待退出重新写入
      end
    end
  end)

-- 当前播放列表对应存储位置
function current_playlist_pos_file()
	local playlist_name = palylist_filename()
	local key = md5.sumhexa(playlist_name)
	print("the playlist is "..playlist_name..",key:"..key)
	latest_playlist_pos_file = playlist_pos_file.."_"..key
	return latest_playlist_pos_file
end

-- 获取播放列表名称
function palylist_filename()
	local playlist = mp.get_property("playlist")
	local data = cjson.decode(playlist)
	if data then
 		return data[1]["playlist-path"]
	end
	return nil
end

-- 需要通过参数: --script-opts=playlist_file=xxxx.m3u参数进行传递真实播放列表
function playlist_name_arg()
	local options = require("mp.options")
	local o = { playlist_file = "" }
	options.read_options(o)

	if o.playlist_file ~= "" then
		local msg = "当前播放列表:" .. o.playlist_file
		mp.osd_message(msg)
		print(msg)
	end
	
end

-- 不一定准确
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

function hello()
	print("hello world")
end
