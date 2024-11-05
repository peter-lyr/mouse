; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/05/21 22:49:27 星期二

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mouse
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
max_middle_counts := 2
max_left_counts := 2
max_wheel_counts := 6
max_circles := 6
max_directions := 8

draw_circle_en := 1

circle_radius := 150
circle_min_transparent := 86
circle_max_transparent := 136

winver := 11

left_margin := 190

If (A_ScreenHeight <= 1080) {
  circle_radius := 50
}

; If (GetWinVer() == "Windows 10") {
;   winver := 10
;   left_margin := 78
; }

circle_diameter := circle_radius * max_circles * 2

circle_colors := []
_color := [0x00FF0000, 0x000000FF, 0x0000FF00]

Loop max_circles {
  circle_colors.Push(_color[Mod(A_index, _color.Length) + 1])
}

no_taskkill_processes := ["explorer.exe"]
