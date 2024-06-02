TermBuf = vim.api.nvim_create_buf(true, false)
TermWin = nil
local is_initialized = false

TermWidth = math.floor(vim.o.columns * 0.8)
TermHeight = math.floor(vim.o.lines * 0.2)

if TermWidth < 50 then
    TermWidth = 50
end
if TermHeight < 20 then
    TermHeight = 20
end

function ToggleTerminal()
    -- Buffer might be deleted when the terminal process exits
    if not vim.api.nvim_buf_is_valid(TermBuf) then
        TermBuf = vim.api.nvim_create_buf(true, false)
        is_initialized = false
    end

    -- Window isn't visible
    if TermWin == nil or not vim.api.nvim_win_is_valid(TermWin) then
        -- Create a new terminal window
        TermWin = vim.api.nvim_open_win(TermBuf, true, {
            relative = "editor",
            width = TermWidth,
            height = TermHeight,
            col = (vim.o.columns - TermWidth) / 2,
            row = 1,
            style = "minimal",
            border = "rounded",
        })

        -- Buffer initialized with terminal?
        -- I only know how to do this after opening the window, that's why it isn't done at startup
        if not is_initialized then
            is_initialized = true

            -- Open the terminal buffer in the new window
            vim.api.nvim_buf_set_option(TermBuf, 'modified', false) -- idk why
            local term_channel = vim.fn.termopen 'fish'

            vim.api.nvim_command 'startinsert'
            vim.api.nvim_chan_send(term_channel, 'cd ' .. vim.fn.getcwd() .. ' && clear_screen\n')
        else
            vim.api.nvim_command 'startinsert'
        end
    else
        -- Close the terminal window if already open
        vim.api.nvim_win_close(TermWin, true)
        TermWin = nil
    end
end
