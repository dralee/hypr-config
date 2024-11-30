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










### fonts
ttf-hack-nerd
ttf-ms-win11-auto-zh_cn
adobe-source-han-serif-cn-fonts
noto-fonts-cjk
noto-fonts-extra

### fcitx
fcitx5
fcitx5-chinese-addons
fcitx5-configtool
fcitx5-gtk
fcitx5-material-color
fcitx5-qt
fcitx5-rime

### zip
7-zip-full
ark
unzip

### waybar env
bridge-utils
brightnessctl

### clipboard
clipboard-sync
cliphist

### alsa voice
aria2
alsa-firmware
alsa-utils

### browser
google-chrome
microsoft-edge-stable-bin

### pacman & yay
archlinuxcn-keyring
yay

### picture
feh   		# picture browser
drawing		# draw something

### password save
browserpass
browserpass-chrome


### work communicate
dingtalk-bin
feishu-bin



aylurs-gtk-shell-git
bottom-git
btrfs-progs
calibre
capstone
catdoc
cmake
ctags-git
dart-sass
dbeaver
debtap
dmg2img
docker
docker-compose
efibootmgr
espeak
evince
fd
feathernotes
firewalld
fish
flameshot-git
flatpak
fmt
grim
gromit-mpx
grub
gtop
gvim
gwenview
hfsprogs

### hyprland env
aquamarine-git   # hyprland build

hyprcursor-git
hypridle-git
hyprlang-git
hyprlock-git
hyprpaper-git
hyprshot
hyprshot-gui-git
hyprwayland-scanner-git

imagemagick
intel-ucode
kdevelop
keystone
khal
kitty
krita
kvantum
less
libreoffice-fresh
lshw
mako
man-pages
mono
musique
mycli
neofetch
network-manager-applet
ntfs-3g
nwg-look-bin
onlyoffice-bin
openbsd-netcat
openoffice-bin
openssh
paccache-hook
pacman-contrib
pandoc-bin
pass
pass-import
pcmanfm-gtk3
pw-volume
python-pdf2image
python-pip
python-xlsx2csv
qemu-base
qemu-full
qemu-guest-agent
qt-heif-image-plugin-git
qt5-heic-image-plugin-git
qt6-heic-image-plugin-git
ranger
rapidjson
rar
rofi-lbonn-wayland-git
rsync
slurp
sof-firmware
spicetify-cli
spotify
telegram-desktop
tk
tomlplusplus
udiskie
unblockneteasemusic-bin
vde2
virt-manager
virt-viewer
visual-studio-code-bin
vulkan-nouveau
w3m
waybar
wechat-universal-bwrap
wf-recorder
wget
whois
wine
wl-clip-persist
wl-clipboard
wlogout
wlr-randr
wofi
wqy-zenhei
xcb-util-errors
xclip
xdg-desktop-portal-gtk
xorg-xinput
