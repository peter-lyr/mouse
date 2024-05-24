; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 22:49:27 星期二

max_middle_counts := 2
max_left_counts := 2
max_wheel_counts := 6
max_circles := 10
max_directions := 8

circle_min_transparent := 16
circle_max_transparent := 36

winver := 11
circle_nums := 6
circle_radius := 150
left_margin := 126

If (GetWinVer() == "Windows 10") {
  winver := 10
  circle_radius := 50
  left_margin := 78
}

circle_diameter := circle_radius * circle_nums * 2

circle_colors := []
_color := [0x00FF0000, 0x000000FF, 0x0000FF00]

Loop circle_nums {
  circle_colors.Push(_color[Mod(A_index, _color.Length) + 1])
}

dpi := GetSystemScreenDpi()
