; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 22:49:27 星期二

max_middle_counts := 2
max_left_counts := 2
max_wheel_counts := 6
max_circles := 6
max_directions := 8

circle_min_transparent := 36
circle_max_transparent := 70

winver := 11
circle_sizes := [150, 450, 750, 1050, 1350, 1650]
left_margin := 126

If (GetWinVer() == "Windows 10") {
  winver := 10
  circle_sizes := [50, 150, 250, 350, 450, 550]
  left_margin := 78
}

circle_colors := ["Red", "Blue", "Green", "Red", "Blue", "Green"]

dpi := GetSystemScreenDpi()
