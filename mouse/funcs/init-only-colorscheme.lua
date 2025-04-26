Home            = vim.fn.expand '$HOME'
Dp              = Home .. [[\Dp]]
DataLazyPlugins = Dp .. [[\lazy\plugins]]

-- 主题
vim.opt.rtp:prepend(DataLazyPlugins .. [[\catppuccin]])
vim.cmd.colorscheme 'catppuccin-frappe'

-- 窗口无边框
vim.cmd('source ' .. string.sub(vim.env.VIMRUNTIME, 1, #vim.env.VIMRUNTIME - 13) .. '\\nvim-qt\\runtime\\plugin\\nvim_gui_shim.vim')
vim.fn['GuiWindowFrameless'](1)
vim.cmd 'GuiWindowOpacity 0.9'
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
