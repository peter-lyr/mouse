; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 22:49:27 星期二

max_middle_counts := 2
max_left_counts := 2
max_wheel_counts := 6
max_circles := 6
max_directions := 8

circle_min_transparent := 16
circle_max_transparent := 36

winver := 11
circle_nums := 6
circle_size := 150
left_margin := 126

If (GetWinVer() == "Windows 10") {
  winver := 10
  circle_size := 50
  left_margin := 78
}

circle_total_size := circle_size * circle_nums * 2

circle_colors := [0x00FF0000, 0x0000FF00, 0x000000FF, 0x00FF0000, 0x0000FF00, 0x000000FF]

dpi := GetSystemScreenDpi()
