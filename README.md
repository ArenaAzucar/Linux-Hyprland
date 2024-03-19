# ArenaNaranja - hyprland

# 说明

该仓库是Naranja的archlinux-hyprland配置。

# 预览

默认启动就是空的，只有一个壁纸。（个人爱好，欣赏壁纸不喜欢有别的东西来吸引我的注意力。）

![image-20240315021212624](https://github.com/ArenaAzucar/Linux-Hyprland/blob/master/assets/image-20240315021212624.png)

waybar启动后的效果。

![image-20240315021535682](https://github.com/ArenaAzucar/Linux-Hyprland/blob/master/assets/image-20240315032247243.png)

![image-20240319043935861](https://github.com/ArenaAzucar/Linux-Hyprland/blob/master/assets/image-20240319043935861.png)

![image-20240315021656961](https://github.com/ArenaAzucar/Linux-Hyprland/blob/master/assets/image-20240315032053058.png)

# 安装

- 配置pacman

    ```sh
    # 修改/etc/pacman.d/mirrorlist
    echo 'Server = https://mirrors.tuna.tsinghua.edu.cn/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
	```

    ```sh
    # 修改/etc/pacman.conf
    echo '[multilib]
    Include = /etc/pacman.d/mirrorlist'>>/etc/pacman.conf
    echo '[archlinuxcn]
    SigLevel = Optional TrustAll
    Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch'>>/etc/pacman.conf
	```

    ```sh
    # 更新pacman
    sudo pacman -Syy
    sudo pacman -S archlinuxcn-keyring
    ```

- 安装需要的软件

    ```bash
    # 安装一些软件需要的依赖,否则可能会报错
    sudo pacman -S base-devel debugedit fakeroot
    # 安装最新的hyprland
    sudo pacman -S hyprland-git
    # 安装项目需要的软件
    sudo pacman -S swaybg-git mpd mpc ncmpcpp pulseaudio grim bluez bluez-utils ulseaudio-bluetooth fcitx5-im fcitx5-pinyin-zhwiki swayidle alacritty-git pcmanfm brightnessctl pulseaudio paru-git ttf-monaco ttf-jetbrains-mono-nerd git mako libnotify wlogout zsh
    oh-my-zsh-git autojump zsh-syntax-highlighting zsh-autosuggestions keyd
    
    paru -S rofi-lbonn-wayland-only-git mpvpaper-git
    ```

    - swaybg壁纸

    - mpd，mpc，ncmpcpp听歌的

    - bluez bluez-utils pulseaudio-bluetooth蓝牙

    - fcitx5-im fcitx5-pinyin-zhwiki 输入法

    - swayidle 息屏

    - alacritty-git 终端模拟器

    - kitty 终端模拟器

    - mako 告警提示, libnotify中的notify-send命令可以发送文本到mako
    
    - grim截图
    
    - wlogout这个是waybar右上角的开始按钮用的
    
    - rofi-lbonn-wayland-only-git软件启动器
    
    - pcmanfm文件管理工具
    
      感觉没啥用，基本用不到，我常用的是joshuto或者yazi
      
      ```bash
      sudo pacman -S joshuto-git 
      sudo pacman -S yazi-git
      ```
      
    - brightnessctl屏幕亮度调整
    
    - pulseaudio音量调整
    
    - keyd 按键修改
    
    - ttf-monaco ttf-jetbrains-mono-nerd 字体
    
    - mpvpaper-git 动态壁纸需要用的
    
    - zsh oh-my-zsh-git autojump zsh-syntax-highlighting zsh-autosuggestions 都是zsh用的
    


- 将该项目配置应用到主机

	克隆:`git clone https://github.com/ArenaAzucar/Linux-Hyprland.git`
	
	```sh
	# 你可以编写一个bash脚本来覆盖你原本的配置(建议可以备份一下自己的配置)
	path=<克隆项目的本地路径>
	# 将.config下的所有文件覆盖到本地的${HOME}/.config/下
	# 里面包含:alacritty kitty waybar hypr neofetch wlogout mako rofi的配置
	# 你需要修改hypr文件夹中的hyprland.conf文件,里面有几个模块,你需要修改binds.conf的一些配置
	cp $path/.config/* ${HOME}/.config -r
	# mpd ncmpcpp
	cp $path/.mpd ${HOME}/ -r
	cp $path/.ncmpcpp ${HOME}/ -r
	gpasswd -a mpd audio
	# zsh配置文件
	cp $path/.zshrc ${HOME}/.zshrc
	# vim配置文件,配的比较垃圾,不建议使用
	cp $path/.vimrc ${HOME}/.vimrc
	# 添加输入法需要的环境变量
	echo 'GTK_IM_MODULE=fcitx5
	QT_IM_MODULE=fcitx5
	SDL_IM_MODULE=fcitx5
	XMODIFIERS=@im=fcitx5' >> /etc/environment
	# keyd配置,将capslook键修改成super,但是又不影响其本身的大小写切换,原本的super也不会有影响
	sudo cp $path/keyd/default.conf /etc/keyd/
	# 自动启动蓝牙服务
	sudo systemctl enable bluetooth
	sudo systemctl start bluetooth
	```
	
	

# 按键

- 我的hyprland按键配置：

  ```bash
  # ## 按键 ## #
  $mainMod = SUPER	# 将win键定义为通用按键，后面大部分都引用该按键，后续更改只需要更改此处即可
  $nMod = ALT		# 同上
  ######## Hypr
  $mainMod,T	# 打开中的terminal
  $mainMod,C # 关闭窗口
  $mainMod,M # 退出hyprland,相当于windows的注销
  $mainMod,E # 打开文件管理器
  $mainMod,v	# 切换窗口浮动
  $mainMod,R # 打开软件启动器
  $mainMod,P # 切换为tiling模式，窗口将保持浮动时的大小
  $mainMod,J # 切换窗口分割方向
  $mainMod,F # 窗口全屏
  ######## waybar
  $mainMod,B # 启动waybar
  $mainMod SHIFT,B # 关闭启动waybar
  ######## 屏幕
  $mainMod,[ # 屏幕亮度减少
  $mainMod,] # 屏幕亮度增加
  ######## 截图
  $mainMod,A 		# 自己选择,保存到剪切板
  ,Print			# 截全屏，保存到指定目录
  $mainMod,Print	# 自己选择，但保存到指定目录
  $nMod,A			# 全屏，保存到剪切板
  ########## mpc（音乐相关）
  $nMod,>		# 下一首歌曲
  $nMod,<		# 上一首歌曲
  ########## 系统音量
  $nMod,]		# 音量加5%（常桉有效）
  $nMod,[		# 音量减5%（常桉有效）
  $nMod SHIFT,] # 音量加15%（常桉有效）
  $nMod SHIFT,[ # 音量减15%（常桉有效）
  ########## hypr窗口操作
  $mainMod,<方向键>	# 切换操作窗口
  $mainMod,0～9	# 切换工作区域
  $mainMod SHIFT,0~9	# 将选中窗口移动到指定工作区域
  $mainMod,<鼠标滚轮>	# 鼠标滚轮切换工作区域
  $mainMod,<鼠标左键> # 移动窗口位置
  $nMod,<鼠标左键>	# 调整窗口大小
  $nMod,<方向键>		# 调整窗口大小
  $mainMod SHIFT,<方向键>		# 移动浮动窗口位置
  $mainMod $nMod,<反向键> 		# 移动窗口位置
  ```
  
- waybar上的功能

  ```bash
  # launcher : Arch图标是操作mpc（音乐相关），左键是暂停播放/开始播放, 右键显示/关闭歌词
  # workspaces:（工作区域）显示
  # tray: 显示启动了的软件
  # ci：歌词显示，暂停音乐会自动消失（这是为将launcher改成【暂停播放/开始播放】的原因），鼠标滚轮可以调整音量（调整的mpd的音量，并不是系统音量），鼠标左键是暂停播放（暂停时该模块会消失，可以点launcher来播放音乐，该模块会自动弹出）。
  # wallpaper：壁纸切换，随机换一个壁纸（需要你自己在对应的路径添加图片）,右键切换动态壁纸
  # backlight：调整屏幕亮度，单点无效，鼠标滚轮可以调整亮度
  # pulseaudip：系统音量调整，单点静音，鼠标滚轮可以调整音量
  # clock：显示时间，单点显示日前，悬浮显示日历
  # battery：显示电量
  # power：显示wlogout
  ```

- keyd(修改按键)

  ```bash
  # 修改配置文件/etc/keyd/default.conf
  [ids]
  *
  [main]
  # 按win键真的很不方便,
  # 将capslock改成meta（SUPER）键，只是添加一些组合键,原本的功能不变
  capslock = overload(capslock_layer,capslock)
  
  [capslock_layer]
  b = M-b
  t = M-t
  v = M-v
  s = M-s
  p = M-p
  j = M-j
  f = M-f
  r = M-r
  e = M-e
  c = M-c
  1 = M-1
  2 = M-2
  3 = M-3
  4 = M-4
  5 = M-5
  6 = M-6
  7 = M-7
  8 = M-8
  9 = M-9
  0 = M-0
  up = M-up
  down = M-down
  left = M-left
  right = M-right
  [ = M-[
  ] = M-]
  # leftmouse = M-leftmouse	
  rightshift = right 		# zsh
  ```
  

# 遇到的问题

1. `waybar`的歌词为什么不显示？歌词文件放在哪里？

   `waybar`中间的歌词需要依赖脚本`waybar/scripts/songLyrics.sh`， 如果你需要修改歌词文件存放路径，那么你需要修改`songLyrics.sh`文件的第6行：

   ```bash
   # #### 修改～/music为你歌词文件的存放路径
   f=`find “~/music” -name "**.lrc" | grep $1 | grep $2`
   ```

   **注意：该脚本只限于`.lrc`歌词文件, 并且当音乐暂停时歌词会消失，所以为把Arch的图标改成里`暂停/开始`音乐。如果歌曲没有找到歌词，那么会显示乱码，如果你有好的办法可以分享一下。**

2. waybar崩溃

   报错:`segmentation fault (core dumped)  waybar`

   不知道怎么处理, 可能是配置文件有问题, 偶尔会出现这个问题.

3. obs录屏问

   1. 问题:obs安装后没有`屏幕采集` 

      ```sh
      # 安装
      sudo pacman -S pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland-git obs-studio-git
      # 修改hyprland配置
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY
      # 重启
      ```
   
   2. 问题:obs有`屏幕采集`,但是采集的是黑屏
   
      ```sh
      # 这个需要修改配置文件
      # 这个是全局生效:/usr/share/applications/com.obsproject.Studio.desktop
      # 当前用户生效: ~/.local/share/applications/com.obsproject.Studio.desktop
      # 修改里面Exec的参数,原本应该是obs,在后面加个 -platform wayland即可
      Exec=obs -platform wayland
      # 重启/注销
      ```

# 参考文档

> hyprland官方wiki：https://wiki.hyprland.org/

> waybar-wiki：https://github.com/Alexays/Waybar/wiki

> https://github.com/notwidow/hyprland

> https://www.bilibili.com/read/cv22707313/

> https://cascade.moe/posts/hyprland-configure/

> https://nth233.top/posts/2023-02-26-Hyprland%E9%85%8D%E7%BD%AE

> https://github.com/prasanthrangan/hyprdots

> https://github.com/LitSKt/Hyprland_Configuration

> 动态壁纸: www.bilibili.com/video/BV1xg4y1j7yH

> neofetch: https://github.com/Chick2D/neofetch-themes/blob/main/small/ozozfetch.conf



