; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 22:49:27 星期二

max_directions := 8
max_circles := 4
max_wheel_counts := 6

circle_min_transparent := 36
circle_max_transparent := 90

winver := 11
circle_sizes := [200, 500, 800, 1100, 1400, 1700, 2100, 2400, 2700]
left_margin := 126

If (GetWinVer() == "Windows 10") {
  winver := 10
  circle_sizes := [100, 300, 500, 700, 900, 1100, 1300, 1500, 1700]
  left_margin := 78
}

circle_colors := ["Red", "Blue", "Green", "Red", "Blue", "Green", "Red", "Blue", "Green"]
