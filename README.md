# interesting
一些有趣的code

## 项目
1. wallpaper（获取himawari8中得卫星图作为PC的桌面）

## 详情
### wallpaper
1. 项目来自[Earth Live Sharp ](https://github.com/bitdust/EarthLiveSharp) 图片均来自向[日葵-8號即時網頁](http://himawari8.nict.go.jp/) python版借鉴[Earth Live Sharp of python](https://github.com/xyangk/EarthLiveSharp)
2. 适用平台：mac、linux
3. 开发语言：shell、python

#### 安装
1. 安装前准备  
git clone https://github.com/code-h/interesting.git 到Home目录下

> 注意：  
> shell：mac=>将项目同目录下的com.wallpaper.launchctl.plist拷贝到$HOME/Library/LaunchAgents，并load  
> python：在$HOME/interesting/wallpaper/py/wallpaper下安装scrapy`pip install scrapy`。mac=>$HOME/interesting/wallpaper/py/wallpaper/auto-start/com.wallpaper.launchctl.plist，拷贝到$HOME/Library/LaunchAgents,并load，linux自启动可以参考[这里](http://jingyan.baidu.com/article/7c6fb428632c3980642c90ce.html)



