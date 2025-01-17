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
badd +458 ~/org/data/p/mouse/mouse/menu.ahk
badd +37 ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
badd +471 ~/org/data/p/mouse/mouse/funcs/utils.ahk
badd +3 ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk
argglobal
%argdel
edit ~/org/data/p/mouse/mouse/menu.ahk
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
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
balt ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk
let s:l = 436 - ((16 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 436
normal! 05|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/switchwindow.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/switchwindow.ahk
endif
balt ~/org/data/p/mouse/mouse/menu.ahk
let s:l = 2 - ((1 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 2
normal! 03|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
endif
let s:l = 36 - ((19 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 36
normal! 05|
wincmd w
argglobal
if bufexists(fnamemodify("~/org/data/p/mouse/mouse/funcs/utils.ahk", ":p")) | buffer ~/org/data/p/mouse/mouse/funcs/utils.ahk | else | edit ~/org/data/p/mouse/mouse/funcs/utils.ahk | endif
if &buftype ==# 'terminal'
  silent file ~/org/data/p/mouse/mouse/funcs/utils.ahk
endif
balt ~/org/data/p/mouse/mouse/funcs/nvim-qt.ahk
let s:l = 471 - ((16 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 471
normal! 0
wincmd w
4wincmd w
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
