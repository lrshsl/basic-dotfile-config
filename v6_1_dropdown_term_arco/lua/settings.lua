BgTransparent = true
NumbersOn = false
vim.g.neovide_transparency = 0.9
FontSize = 7.5

vim.cmd('set guifont=JetBrains\\ Mono\\ Thin:h' .. FontSize)
--set guifont=Source\ Code\ Pro\ Light:h7.5

--> Ligature test: -> 1/2 >= 0 |>

vim.cmd [[
set encoding=utf-8
set exrc

filetype plugin indent on
syntax enable

" Increment alphanumerical characters with <C-a> and <C-x>
set nrformats=alpha

" Appearance "
set guicursor=n-v-c-sm-i-ci-ve:block,r-cr-o:hor20

"set colorcolumn=80

" Colors "
set termguicolors

let g:sonokai_transparent_background = 1
colorscheme sonokai  " AFTER other settings
hi NormalFloat guibg=#000000

"colorscheme bordeau

set nowrap

" Tabs vs Spaces "
set noet ts=3 sts=3 sw=3

set foldmethod=marker
set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤

augroup TAB_VS_SPACES_AUGROUP
	autocmd!

	autocmd BufNewFile,BufRead Makefile          :setlocal list et! list listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤
	autocmd BufNewFile,BufRead Makefile          :echom "Makefile recognised. Now using tabs for indent"

	autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp   :setlocal et ts=2 sts=2 sw=2
	autocmd BufNewFile,BufRead *.c,*.h,*.cpp,*.hh,*.hpp   :setlocal list listchars=tab:->,trail:~,leadmultispace:·\|,nbsp:¤

	autocmd BufNewFile,BufRead *.nim                      :setlocal et ts=2 sts=2 sw=2
	autocmd BufNewFile,BufRead *.nim                      :setlocal list listchars=tab:->,trail:~,leadmultispace:·\|,nbsp:¤
augroup END

augroup FILE_TEMPLATES_AUGROUP
	au!

	au BufNewFile Makefile                   0r ~/.config/nvim/templates/general/Makefile.template | lua InsertSubstitution('Project Name')
	au BufNewFile Doxyfile                   0r ~/.config/nvim/templates/general/Doxyfile.template | lua InsertSubstitution('Project Name')
	au BufNewFile .clang-format              0r ~/.config/nvim/templates/c/clang-format.template

	au BufNewFile *.h                        0r ~/.config/nvim/templates/c/h.template | lua InsertSubstitution('filename')
	au BufNewFile *.c                        0r ~/.config/nvim/templates/c/c.template | lua InsertSubstitution('filename')
	au BufNewFile header.h                   0r ~/.config/nvim/templates/c/header.h.template

	au BufNewFile .gitignore                 :lua LoadTemplate("general/gitignore.template")
augroup END
]]

function InsertSubstitution(pattern)
	local go_left = vim.api.nvim_replace_termcodes('<left><left>', true, true, true)
	vim.api.nvim_feedkeys(':%s/<<\\[' .. pattern .. '\\]>>//g' .. go_left, 'n', false)
end

function Subtitude(pattern, value, flags)
	vim.cmd(':%s/<<\\[' .. pattern .. '\\]>>/' .. value .. '/' .. flags)
end

function LoadTemplate(name)
	vim.cmd("0r ~/.config/nvim/templates/" .. name .. ".template")
end

function InitProject()
	local language = AskUserChoice('Select a language', { 'C', 'C++', 'Rust', 'Nim', 'Python' })
	local project_name = vim.fn.input('Project name: ')
	local project_description = vim.fn.input('Brief description: ')

	if language == 'Rust' then
		print('Initializing Rust project...')

		-- Create the project directory
		local project_dir = vim.fn.getcwd() .. '/' .. project_name
		vim.fn.mkdir(project_dir, 'p')
		vim.cmd('cd ' .. project_dir)

		-- Initialize the Rust project using Cargo
		local success, _ = os.execute('cargo new .')
		if not success then
			print('Failed to initialize Rust project with Cargo.')
			return
		end

		-- Optionally, you can add additional files or modify existing ones
		local cargo_toml = io.open(project_dir .. '/Cargo.toml', 'a')
		if cargo_toml then
			cargo_toml:write('\n[package]\ndescription = "' .. project_description .. '"\n')
			cargo_toml:close()
		end

		print('Rust project initialized successfully.')
	end
end

function AskUserChoice(prompt, choices)
	local pickers = require('telescope.pickers')
	local finders = require('telescope.finders')
	local actions = require('telescope.actions')
	local action_state = require('telescope.actions.state')

	local co = coroutine.running()

	pickers.new({}, {
		prompt_title = prompt,
		finder = finders.new_table {
			results = choices
		},
		sorter = require('telescope.config').values.generic_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				actions.close(prompt_bufnr)
				local selection = action_state.get_selected_entry()
				coroutine.resume(co, selection.value)
			end)
			return true
		end,
	}):find()

	return coroutine.yield()
end

function ToggleNumbers()
	if NumbersOn == true then
		vim.cmd [[ set nu! rnu! ]]
	else
		vim.cmd [[ set nu rnu ]]
	end
	NumbersOn = not NumbersOn
end

function ChangeFontSize(val)
	return function()
		FontSize = FontSize + val
		vim.opt.guifont = "JetBrains Mono Thin:h" .. FontSize
	end
end

function SetFontSizeCurry(val)
	return function()
		FontSize = val
		vim.opt.guifont = "JetBrains Mono Thin:h" .. val
	end
end

function BgSetTransparencyCurry(val)
	if vim.g.neovide then
		return function()
			vim.g.neovide_transparency = 1 - val
		end
	end
	return function()
		print('No known gui detected, transparency might not work properly')
		if val > 0.5 then
			vim.cmd [[ hi Normal guibg=#111111 ctermbg=black ]]
		else
			vim.cmd [[ hi Normal guibg=NONE ctermbg=NONE ]]
		end
	end
end

function ToggleTransparentBg()
	if BgTransparent == true then
		BgSetTransparencyCurry(0)()
	else
		BgSetTransparencyCurry(1)()
	end
	BgTransparent = not BgTransparent
end

--> Settings bindings
require 'which-key'.add {
	group = 'Settings',
	{ '<space>,l', ':Limelight!!<CR>',  desc = 'Limelight',           silent = true, },
	{ '<space>,g', ':Goyo 90%x90%<CR>', desc = 'Goyo',                silent = true, },
	{ '<space>,G', ':Goyo<CR>',         desc = 'Goyo (deactivate)',   silent = true, },
	{ '<space>,n', ToggleNumbers,       desc = 'Toggle line numbers', silent = true, },
	{
		group = '',
	},
	{
		group = 'Transparency',
		{ '<space>,bb',  ToggleTransparentBg,          desc = 'Toggle transparency', silent = true, },
		{ '<space>,bt`', BgSetTransparencyCurry(0),    desc = '0',                   silent = true, },
		{ '<space>,bt1', BgSetTransparencyCurry(0.03), desc = '1',                   silent = true, },
		{ '<space>,bt2', BgSetTransparencyCurry(0.05), desc = '2',                   silent = true, },
		{ '<space>,bt3', BgSetTransparencyCurry(0.08), desc = '3',                   silent = true, },
		{ '<space>,bt4', BgSetTransparencyCurry(0.15), desc = '4',                   silent = true, },
		{ '<space>,bt5', BgSetTransparencyCurry(0.2),  desc = '5',                   silent = true, },
		{ '<space>,bt6', BgSetTransparencyCurry(0.3),  desc = '6',                   silent = true, },
		{ '<space>,bt7', BgSetTransparencyCurry(0.5),  desc = '7',                   silent = true, },
		{ '<space>,bt8', BgSetTransparencyCurry(0.75), desc = '8',                   silent = true, },
		{ '<space>,bt9', BgSetTransparencyCurry(0.9),  desc = '9',                   silent = true, },
		{ '<space>,bt0', BgSetTransparencyCurry(1.0),  desc = '10',                  silent = true, },
	},
	{
		group = 'Font',
		{ '<space>,f`', SetFontSizeCurry(6),  desc = '6',  silent = true, },
		{ '<space>,f1', SetFontSizeCurry(7),  desc = '7',  silent = true, },
		{ '<space>,f2', SetFontSizeCurry(8),  desc = '8',  silent = true, },
		{ '<space>,f3', SetFontSizeCurry(9),  desc = '9',  silent = true, },
		{ '<space>,f4', SetFontSizeCurry(10), desc = '10', silent = true, },
		{ '<space>,f5', SetFontSizeCurry(11), desc = '11', silent = true, },
		{ '<space>,f6', SetFontSizeCurry(12), desc = '12', silent = true, },
		{ '<space>,f7', SetFontSizeCurry(13), desc = '13', silent = true, },
		{ '<space>,f8', SetFontSizeCurry(16), desc = '16', silent = true, },
		{ '<space>,f9', SetFontSizeCurry(20), desc = '20', silent = true, },
		{ '<space>,f0', SetFontSizeCurry(30), desc = '30', silent = true, },
	},
	{
		group = 'Whitespace',
		{
			group = 'List',
			{ '<space>,wll', ':set list!<CR>',                                                      desc = 'Toggle', silent = true, },
			{ '<space>,wl2', [[ :set listchars=tab:-->,trail:~,leadmultispace:·\|,nbsp:¤ <CR> ]],   desc = '2',      silent = true, },
			{ '<space>,wl3', [[ :set listchars=tab:-->,trail:~,leadmultispace:··\|,nbsp:¤ <CR> ]],  desc = '3',      silent = true, },
			{ '<space>,wl4', [[ :set listchars=tab:-->,trail:~,leadmultispace:···\|,nbsp:¤ <CR> ]], desc = '4',      silent = true, },
		},
		{ '<space>,wls', ':set et <CR>',   desc = 'Use spaces', silent = true, },
		{ '<space>,wlt', ':set noet <CR>', desc = 'Use tabs',   silent = true, },
		{
			group = 'Width of indentation',
			{ '<space>,wwd', ':set ts=3 sts=3 sw=3  <CR>', desc = 'Default', silent = true, },
			{ '<space>,ww1', ':set ts=1 sts=1 sw=1 <CR>',  desc = '1',       silent = true, },
			{ '<space>,ww2', ':set ts=2 sts=2 sw=2 <CR>',  desc = '2',       silent = true, },
			{ '<space>,ww3', ':set ts=3 sts=3 sw=3 <CR>',  desc = '3',       silent = true, },
			{ '<space>,ww4', ':set ts=4 sts=4 sw=4 <CR>',  desc = '4',       silent = true, },
			{ '<space>,ww8', ':set ts=8 sts=8 sw=8 <CR>',  desc = '8',       silent = true, },
		},
	}
}
