TermBuf = vim.api.nvim_create_buf(true, false)
TermWin = nil
local is_initialized = false

local int = math.floor

MIN_TERM_WIDTH = 50
MIN_TERM_HEIGHT = 12

local term_width = int(vim.o.columns * 0.8)
local term_height = 20
local term_pos_x = (vim.o.columns - term_width) / 2
local term_pos_y = 1

TermLoadPreset = function(n)
	if n == 0 then
		SetTermWidth(0.8, true)
		SetTermHeight(20, false)
		SetTermPos(int(vim.o.columns * 0.1) - 2, 1, false)
	elseif n == 1 then
		SetTermWidth(0.5, true)
		SetTermHeight(vim.o.lines - 6, false)
		SetTermPos(int(vim.o.columns * 0.5) - 2, 1, false)
	else
		print("Unknown preset")
	end
end

SetTermWidth = function(w, relative)
	if relative then
		w = int(vim.o.columns * w)
	end
	if w < MIN_TERM_WIDTH then
		term_width = MIN_TERM_WIDTH
	else
		term_width = w
	end
end

SetTermHeight = function(h, relative)
	if relative then
		h = int(vim.o.lines * h)
	end
	if h < MIN_TERM_HEIGHT then
		term_height = MIN_TERM_HEIGHT
	else
		term_height = h
	end
end

GetTermWidth = function()
	return term_width
end

GetTermHeight = function()
	return term_height
end

local reload = function()
	local config = vim.api.nvim_win_get_config(TermWin)
	config.col = term_pos_x
	config.row = term_pos_y
	vim.api.nvim_win_set_config(TermWin, config)
end

SetTermPos = function(x, y, relative)
	if relative then
		term_pos_x = int(x * vim.o.colums)
		term_pos_y = int(y * vim.o.lines)
	else
		term_pos_x = x
		term_pos_y = y
	end
end

MoveTermUp = function()
	if term_pos_y >= 1 then
		term_pos_y = term_pos_y - 1
	end
	reload()
end

MoveTermDown = function()
	if term_pos_y <= vim.o.lines then
		term_pos_y = term_pos_y + 1
	end
	reload()
end

MoveTermLeft = function()
	if term_pos_x >= 1 then
		term_pos_x = term_pos_x - 1
	end
	reload()
end

MoveTermRight = function()
	if term_pos_x <= vim.o.columns then
		term_pos_x = term_pos_x + 1
	end
	reload()
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
			width = GetTermWidth(),
			height = GetTermHeight(),
			col = term_pos_x,
			row = term_pos_y,
			style = "minimal",
			border = "rounded",
		})

		-- Buffer initialized with terminal?
		-- I only know how to do this after opening the window, that's why it isn't done at startup
		if not is_initialized then
			is_initialized = true

			-- Open the terminal buffer in the new window
			vim.api.nvim_buf_set_option(TermBuf, 'modified', false) -- idk why
			local term_channel = vim.fn.termopen("fish --init-command=\"builtin cd " .. vim.fn.getcwd() .. "\"")

			-- vim.api.nvim_chan_send(term_channel, 'cd ' .. vim.fn.getcwd() .. ' && clear_screen\n')
		end

		vim.api.nvim_command 'startinsert'
	else
		-- Close the terminal window if already open
		SetTermWidth(vim.api.nvim_win_get_width(TermWin), false)
		SetTermHeight(vim.api.nvim_win_get_height(TermWin), false)
		vim.api.nvim_win_close(TermWin, true)
		TermWin = nil
	end
end
