local playlist_pos_file = "/tmp/mpv_playlist_pos"  -- 记录播放进度的文件
local mp = require("mp")

-- 退出时记录播放位置
mp.register_event("shutdown", function()
    local pos = mp.get_property_number("playlist-pos", -1)
    local file = io.open(playlist_pos_file, "w")
    if file then
      file:write(pos)
      file:close()
    end
  end)

-- 启动时恢复播放位置
mp.register_event("start-file", function()
	-- print("start a file")
    local file = io.open(playlist_pos_file, "r")
    if file then
      local pos = tonumber(file:read("*all"))
      file:close()
      if pos and pos > 0 then
        mp.set_property("playlist-pos", pos)
		os.remove(playlist_pos_file) -- 删除原来的文件,以待退出重新写入
      end
    end
  end)

