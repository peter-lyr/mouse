; Copyright (c) 2024 liudepei. All Rights Reserved.
; create at 2024/06/13 15:54:06 星期四

d := "down"

A(1, 1, 1, 1, d, [
  "R", W("Home", S("{Home}")),
  "U", W("PgUp", S("{PgUp}")),
  "D", W("PgDn", S("{PgDn}")),
])

A(1, 1, 2, 1, d, [
  "R", W("End", S("{End}")),
  "U", W("PgUp", S("{PgUp}")),
  "D", W("PgDn", S("{PgDn}")),
])

A(1, 1, 1, 2, d, [
  "R", W("Ctrol-Home", S("^{Home}")),
  "U", W("PgUp", S("{PgUp}")),
  "D", W("PgDn", S("{PgDn}")),
])

A(1, 1, 2, 2, d, [
  "R", W("Ctrol-End", S("^{End}")),
  "U", W("PgUp", S("{PgUp}")),
  "D", W("PgDn", S("{PgDn}")),
])

; ==========
; 20250219
; ==========

; A(1, 1, 1, 1, d, [
;   "R", W("ActivateCycleDownloaderCodeBlocks", ActivateCycleDownloaderCodeBlocks),
;   "U", W("ActivateCycleDownloaderCodeBlocks", ActivateCycleDownloaderCodeBlocks),
;   "D", W("ActivateCycleDownloaderCodeBlocks", ActivateCycleDownloaderCodeBlocks),
; ])

; A(1, 1, 1, 2, d, [
;   "R", W("ActivateCycleWeChatWXWork", ActivateCycleWeChatWXWork),
;   "U", W("ActivateCycleWeChatWXWork", ActivateCycleWeChatWXWork),
;   "D", W("ActivateCycleWeChatWXWork", ActivateCycleWeChatWXWork),
; ])

; A(1, 1, 1, 3, d, [
;   "R", W("ActivateCycleExplorerMsedge", ActivateCycleExplorerMsedge),
;   "U", W("ActivateCycleExplorerMsedge", ActivateCycleExplorerMsedge),
;   "D", W("ActivateCycleExplorerMsedge", ActivateCycleExplorerMsedge),
; ])

; A(1, 1, 1, 5, d, [
;   "R", W("MinimizeAll", MinimizeAll),
;   "U", W("MinimizeAll", MinimizeAll),
;   "D", W("MinimizeAll", MinimizeAll),
; ])

; A(1, 1, 1, 6, d, [
;   "R", W("ExplorerAllTabsToOneWindow", ExplorerAllTabsToOneWindow),
; ])
