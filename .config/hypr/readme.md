### Hyprland
#### backup
备份0.55.0以前的版本配置信息

#### lua config
version 0.55 use lua

##### 定义用于区分不同工作环境的变量，以便个性化加载
需要在启动hyprland前进行设置该配置
```bash
$ vim /etc/environment
...
# Hyprland运行环境，work/home/laptop/...
HYPR_RUN_PC_ENV=work
```


##### 测试配置
自从0.55.0版本开始，官方使用了lua方式进行配置
test lua script
```bash
luac -p ~/.config/hypr/hyprland.lua
```

test
```bash
Hyprland --config ~/.config/hypr/hyprland.lua
```

