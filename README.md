c:\users\llydr\documents\autohotkey

ahk2exe

![20240520-145154](.images/77cc8e92.png)

![20240520-145559](.images/1da1ac60.png)

# 240521-00h56m

## [x] TODODONE: 全局鼠标

除了热键外,其他所有鼠标操作,都要经过按下鼠标右键

按下鼠标右键后,可以通过在不同的区域内,以以下三种方式,去做不同的事情

- `松开右键`
- `向上滚动滚轮`
- `向下滚动滚轮`

### [x] TODODONE:失效触发

按下鼠标右键后,以下事件会导致其他事件失效

- `滚动滚轮`,会让`松开右键`的事件失效
- `按下左键`或者`中键`,会让以上三种事件均失效

# 240521-01h06m

## [ ] TODO: 改变窗口位置和大小

触发后,右键已经松开

这时可以通过`左键`和`中键`去实现

完毕之后要退出,则可通过单击一次`右键`来完成

### [ ] TODO: 增加功能

记录每次移动或大小的改变,以便撤销或者回复操作(可选)

# 240522-12h02m

目前的情况:

center LButton/WheelUp/Down -> wheel_count

- [x] TODODONE: 增加两个维度

center WheelUp/Down -> wheel_count
center LButton -> left_count
center MButton -> middle_count

# 240523-20h16m

- [x] TODODONE: move window和resize window需要限制在第一个元以外和第二元以内(包括),其他的不处理
- [ ] TODO: 其他的用来Ctrl-RButton或者Ctrl-LButton

# 240524-12h49m

- [ ] FIX: 当wheel_count不等于1时,RButton & LButton或者RButton & MButton会让内存占用从3.3M升到24M
