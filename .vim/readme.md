### dependencies
#### software
```bash
sudo pacman -S waybar wofi  # status bar & command quick menu
sudo pacman -S hyprpicker hyprlock wlogout
sudo pacman -S hyprpaper mako
sudo pacman -S grim slurp hyprshot hyprshot-gui-git # hypr screen shot
yay -S flameshot    # screen shot
yay -S wf-recorder  # screen record
sudo pacman -S rofi-lbonn-wayland-git
sudo pacman -S wl-clipboard wl-clip-persist-git cliphist
sudo pacman -S xdg-desktop-portal
sudo pacman -S kitty pcmanfm  # terminal & file manager
yay -S ranger # termial file manager
sudo pacman -S google-chrome-stable microsoft-edge-stable
```
#### fonts
```bash
sudo pacman -S adobe-source-han-serif-cn-fonts wqy-zhenhei # open fonts
sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra # google fonts
```
##### fonts for waybar
```
yay -S nerd-fonts-noto-sans-mono
yay -S awesome-git
```
#### sound
```bash
sudo pacman -S sof-firmware alsa-firmware alsa-ucm-conf # sound firmware
```
#### input method & disk utils
```bash
yay -S fcitx5-im fcitx5-chinese-addons fcitx5-material-color # input method
yay -S ntfs-3g # NTFS hard disk
yay -S udiskie # usb auto mount
```

#### python
``` bash
pip install lunar_python # for lunar date(hyprlock & status bar)
```

### laptop
```
yay -S brightnessctl  # brightness
```
#### qt lib
```bash
yay -S qt5-wayland qt6-wayland
yay -S nwg-look qt5ct
yay -S xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
```

#### sddm theme
https://github.com/3ximus/aerial-sddm-theme
```bash
git clone git@github.com:3ximus/aerial-sddm-theme.git
mv aerial-sddm-theme /usr/share/sddm/themes
sddm-greeter --test-mode --theme aerial-sddm-theme/ # test the theme show
```
* config
```bash
$ vim /etc/sddm/sddm.d/xxx.conf
...
Current=aerial-sddm-theme
```


### 分隔语法
linesplitconf语法
syntax/linesplitconf.vim
ftdetect/linesplitconf.vim
文件扩展名为：.dl
param.dl
```dl
# 2026.1.23 by dralee
# 以空行为分隔配置块，以:分隔配置项
# global为全局参数配置块，其中配置的项可供其他的配置块中引用，如header中的值，body值，url中值等
# 多个配置块通过空行分隔
# 固定参数：
#   url：指定请求的链接
#   time: 指定请求的资源，默认为1次
#   delay: 多次请求的情况下，间隔多少秒，支持小数
#   body： 指定请求体
#   同一块中其他配置名称皆自动添加为header（请求头）
# 如果多个文件需要引用其它文件中配置，如一些公共配置，可抽取为公共配置文件
#  eg: global.dl或base.dl等
# 在需要引用的文件中通过@include xxx.dl命令进行引入（文件路径支持相对路径或绝对路径）
# 引入的文件，如果相对路径，加载顺序为，配置同级->命令运行目录同级
# 如果多个公共配置文件，需要保持global部分配置的变量不重复，否则可能导致不可预知的覆盖情况
#@include base.dl

# 全局配置，主要定义一些参数以供请求中使用，参数使用方式为${name}格式
global
agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/237.84.2.178 Safari/537.36
content-type: application/json
# fat env
product-host: http://fat-product-api.z9soft.cn
targetplan-host: http://fat-targetplan-api.z9soft.cn
tenant-id: 1844760743417786368
member-id: 1844913351658876928
client-id: 1c45b917db7841259a65c86ee1f266ca
token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBY2NvdW50SWQiOiIxODQ0OTEyOTYwNzkzNzQxMzEyIiwiRWZmZWN0aXZlVGltZSI6IjE3Njg4OTk0MzgxOTkiLCJFeHBpcmVzSW4iOiIxNzY5NTA0MjM4MTk5IiwiQXVkaWVuY2UiOiLpq5jnu7TogaoiLCJJc3N1ZXIiOiLms6jkuZ3kupHmnI0iLCJleHAiOjE3Njk1MDQyMzgsImlzcyI6InVzZXJjZW50ZXIiLCJhdWQiOiIxODQ0OTEyOTYwNzkzNzQxMzEyIn0.f9T7R3HO1FdwAzcUUJCiIOOZ1yr4YWlUhtB9mvU9J70


# ============================================== product service ==============================================
# spu list url request
spulist
url: ${product-host}/product/v1/product/spulist
method: POST
# loop request times
time: 5
# delay seconds
delay: 0.1
usc-tk-tenant: ${tenant-id}
usc-tk-member: ${member-id}
usc-cid: ${client-id}
User-Agent: ${agent}
Authorization: Bearer ${token}
Content-Type: ${content-type}
body: {
    "prodDatabaseId": "0",
    "categoryIds": [],
    "brandIds": [],
    "includeSkuCategory": 10,
    "excludeSkuId": "0",
    "includeSkuId": "0",
    "spuName": "",
    "spuNameEn": "",
    "skuName": "",
    "skuNameEn": "", ${xxxx}
    "internalSkus": [],
    "isIntSkusFuzzyMatch": false,
    "internalSpus": [],
    "pageIndex": 1,
    "pageSize": 10
}

aa-xxx
aa: "ssds
asdfsad
asdfsdfd
"
aaa: 'asadfasd
asdfsadf
asdfsadfasdfsdaf
asdfsadfsad'
```

### 键值配置语法
keyvalueconf
syntax/keyvalueconf.vim
ftdetect/keyvalueconf.vim
文件扩展名为：.kv
demo.kv
```kv
# xxx
routing_key: rk-hello 
exchange: ex-hello
exchange_type: direct
queue: ex-queue 
message_type: exchange
body: this is the body data for rabbitmq, you can set muliline for it.
like this now, it ok for 2025.8.18.
aaa: xxcasdf
sddw: fwqfed,"1234213",asdww
ddd: "hello world
asdfasdf"
```

### 替换项配置语法
replaceconf
syntax/replaceconf.vim
ftdetect/replaceconf.vim
文件扩展名为：.tr
demo.tr
```tr
# 源数据==>目标数据
# 如将_dev_替换成_fat_
_dev_==>_fat_
_aas==>123423
asdf&sasdf==>1234123xxxasdf
as$dfasdf==>1234123xxxasdf
```




