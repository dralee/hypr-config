### 说明
由于mpv使用的版本为luajit，因此安装类库时需要指定版本号为5.1
使用如`luarocks --lua-version=5.1 install md5`方式安装，该安装方式默认位置为`~/.luarocks`下，因此使用类库时，需要在lua脚本前，引入该路径：
```lua
-- 加载luajit版本(即lua5.1)版本的库
package.cpath = package.cpath .. ";/home/dralee/.luarocks/lib/lua/5.1/?.so"
```
* 如cjson
```bash
luarocks --lua-version=5.1 install lua-cjson
```
* 如md5
```bash
luarocks --lua-version=5.1 install md5
```

之后再使用类库
```lua
package.cpath = package.cpath .. ";/home/dralee/.luarocks/lib/lua/5.1/md5/?.so"
local cjson = require("cjson")
local md5 = require("md5")

cjson.encode(xxx)
cjson.decode(xxx)

md5.sumhexa("xxxx")

```
#### 由于luajit中使用以上安装的md5方式都无法正确加载，因此换成纯lua写的md5
https://github.com/kikito/md5.lua/blob/master/md5.lua


### 自动化安装
```bash
./install.sh
```


