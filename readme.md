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
