### zsh
#### 安装步骤
```bash
# 安装zsh
sudo pacman -S zsh

# 语法高亮
sudo pacman -S zsh-syntax-highlighting

# 命令建议
sudo pacman -S zsh-autosuggestions

# eza 替代 ls
sudo pacman -S eza

# bat 替代 cat
sudo pacman -S bat

# fd 替代 find
sudo pacman -S fd

# ripgrep 替代 grep，使用时 rg
sudo pacman -S ripgrep

# 搜索神器 Ctrl+R可自动提示
sudo pacman -S fzf

# 安装流行主题
sudo pacman -S zsh-theme-powerlevel10k-git
# 配置 使用库中配置文件，因此不需要
# p10k configure

# 进入并加载
zsh
source ~/.zshrc

```
install for single command:
```bash
sudo pacman -S zsh zsh-syntax-highlighting zsh-autosuggestions eza bat fd ripgrep fzf zsh-theme-powerlevel10k-git
```


#### 设置默认shell
可选，替换为默认shell
```bash
echo $SHELL
chsh -s /bin/zsh
```
重新登录后生效
