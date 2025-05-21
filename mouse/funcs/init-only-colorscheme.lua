-- 测试上电时长
local debug_time_en = 0
local f_s_time
if debug_time_en == 1 then
  f_s_time = vim.fn.reltime()
end
-- 调用示例
-- debug_time_do(debug.getinfo(1))
local function debug_time_do(info)
  if debug_time_en == 1 then
    print(string.format('## %s# %d %d', info['source'], info['currentline'], vim.fn.reltimefloat(vim.fn.reltime(f_s_time)) * 1000))
  end
end

-- <leaser>ts
-- :source %:p
-- 复制到~\p\mouse\mouse\funcs\目录下:
-- Ctrl+Shift+Enter在explorer里用nvim-qt打开文件或文件夹
if vim.g.loaded then
  vim.fn.system(string.format('copy /y "%s" "%s\\%s"', vim.api.nvim_buf_get_name(0), vim.fn.expand '$HOME', '\\p\\mouse\\mouse\\funcs\\init-only-colorscheme.lua'))
  return
end
vim.g.loaded    = 1

-- 变量
Home            = vim.fn.expand '$HOME'
Dp              = Home .. [[\Dp]]
DataLazyPlugins = Dp .. [[\lazy\plugins]]

-- 主题
vim.opt.rtp:prepend(DataLazyPlugins .. [[\catppuccin]])
-- vim.cmd.colorscheme 'catppuccin-frappe'
vim.cmd.colorscheme 'slate' -- 节省上电时间
-- debug_time_do(debug.getinfo(1))

-- 窗口无边框
vim.cmd('source ' .. string.sub(vim.env.VIMRUNTIME, 1, #vim.env.VIMRUNTIME - 13) .. '\\nvim-qt\\runtime\\plugin\\nvim_gui_shim.vim')
vim.fn['GuiWindowFrameless'](1)
-- vim.cmd 'GuiWindowOpacity 0.9'
vim.fn['GuiWindowMaximized'](0)
vim.fn['GuiWindowMaximized'](1)
vim.fn['GuiWindowMaximized'](0)

-- 还原窗口
vim.api.nvim_create_autocmd('VimLeavePre', {
  desc = 'vimleavepre',
  callback = function()
    vim.fn['GuiWindowFullScreen'](0)
    vim.fn['GuiWindowMaximized'](0)
    vim.fn['GuiWindowFrameless'](0)
  end,
})

-- 主键
vim.g.mapleader      = ' '
vim.g.maplocalleader = ','

-- 路径
StdConfig            = vim.fn.stdpath 'config' .. '\\'

-- funcs
-- vim.opt.rtp:prepend(StdConfig .. 'funcs') -- 不要额外的功能

-- 按键映射
vim.keymap.set('n', '<leader>oi', '<cmd>e ' .. StdConfig .. 'init-only-colorscheme.lua<CR>')
vim.keymap.set('n', '<leader>sc', '<cmd>source %:p<CR>')
-- debug_time_do(debug.getinfo(1))
