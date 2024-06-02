local buf = vim.api.nvim_create_buf(false, true)
--local term = vim.api.nvim_open_term(buf, {})

local termwidth = math.floor(vim.o.columns / 2)
if termwidth < 50 then
    termwidth = 50
end
local termheight = 20

-- Open a popup window
local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = termwidth,
    height = termheight,
    col = (vim.o.columns - termwidth) / 2,
    row = 1,
    style = 'minimal',
})

-- vim.api.nvim_win_set_buf(win, buf)
vim.api.nvim_buf_set_option(buf, 'modified', false)
local term = vim.fn.termopen 'fish' -- nvim_open_term doesn't open a terminal..

vim.api.nvim_command 'startinsert'
vim.api.nvim_chan_send(term, 'cd ' .. vim.fn.getcwd() .. ' && clear_screen\n')

vim.api.nvim_command 'stopinsert'
vim.api.nvim_win_close(win, true)

function ToggleTerminal()
    if win ~= nil and vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
        win = nil
    else
        win = vim.api.nvim_open_win(buf, true, {
            relative = 'editor',
            width = termwidth,
            height = termheight,
            col = (vim.o.columns - termwidth) / 2,
            row = 1,
            style = 'minimal',
        })
        vim.api.nvim_win_set_buf(win, buf)
        vim.api.nvim_command 'startinsert'
    end
end

vim.keymap.set('t', 'tn', ToggleTerminal, { noremap = true, silent = true })
vim.keymap.set('n', '<space>t', ToggleTerminal, { noremap = true, silent = true })
