let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +42 ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
badd +466 ~/org/data/p/mouse/mouse/funcs/utils.ahk
badd +1 ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk
badd +95 ~/org/data/p/mouse/mouse/funcs/explorer.ahk
badd +1 ~/org/data/p/mouse/mouse/funcs/wxwork.ahk
badd +85 ~/org/data/p/mouse/mouse/funcs/hjkl.ahk
badd +439 ~/org/data/p/mouse/mouse/menu.ahk
badd +7 ~/org/data/p/mouse/main.ahk
badd +12 ~/org/data/p/mouse/mouse.vim
argglobal
%argdel
edit ~/org/data/p/mouse/mouse/funcs/wxwork.ahk
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd w
wincmd _ | wincmd |
split
wincmd _ | wincmd |
split
2wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt ~/org/data/p/mouse/mouse/funcs/explorer.ahk
let s:l = 36 - ((12 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 36
normal! 03|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse.vim", ":p")) | buffer ~/org/data/p/mouse/mouse.vim | else | edit ~/org/data/p/mouse/mouse.vim | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse.vim
endif
balt ~/org/data/p/mouse/mouse/funcs/wxwork.ahk
let s:l = 12 - ((11 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 12
normal! 03|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/explorer.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/explorer.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/explorer.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/explorer.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/hjkl.ahk
let s:l = 95 - ((0 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 95
normal! 06|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/hjkl.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/hjkl.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/hjkl.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/hjkl.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/explorer.ahk
let s:l = 85 - ((10 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 85
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/switchwindow.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/explorer.ahk
let s:l = 1 - ((0 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/menu.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/menu.ahk | else | edit ~/org/data/p/mouse/mouse/menu.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/menu.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk
let s:l = 439 - ((7 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 439
normal! 033|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/main.ahk", ":p")) | buffer ~/org/data/p/mouse/main.ahk | else | edit ~/org/data/p/mouse/main.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/main.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
let s:l = 7 - ((6 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 7
normal! 0
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/explorer.ahk
let s:l = 41 - ((13 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 41
normal! 05|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/utils.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/utils.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/utils.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/utils.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
let s:l = 498 - ((19 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 498
normal! 05|
wincmd w
2wincmd w
wincmd =
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
