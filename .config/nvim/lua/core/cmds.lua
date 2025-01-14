local cmd = vim.api.nvim_create_user_command
local autocmd = vim.api.nvim_create_autocmd

cmd("CopyBufferPath", "let @+ = expand('%:p')", {})

local function split_string_by_white(str)
	if string.len(str) == 0 then
		return { 0 }
	end
	local t = {}
	for w in string.gmatch(str, "([^%s]+)") do
		table.insert(t, w)
	end
	return t
end

cmd("DelBuf", function(opts)
	local args = split_string_by_white(opts.args)
	local all = false
	for _, value in ipairs(args) do
		local bufn = tonumber(value)
		if bufn == nil then
			goto continue
		end
		if
			not vim.api.nvim_buf_is_valid(bufn)
			and not vim.api.nvim_buf_is_loaded(bufn)
		then
			goto continue
		end
		if bufn == 0 then
			bufn = vim.api.nvim_get_current_buf()
		end
		local opt = { force = false, unload = false }
		if vim.fn.getbufvar(bufn, "&mod") == 1 then
			if all then
				vim.cmd("silent " .. bufn .. "bufdo :w")
			else
				::try_again::
				local input = vim.fn.input(
					"Are you sure to save and delete buffer `"
						.. vim.api.nvim_buf_get_name(bufn)
						.. "`? {(y)es, (n)o, (i)gnore, (a)ll, (c)ancel} "
				)
				-- process user input
				if input == "yes" or input == "y" then
					vim.cmd("silent " .. bufn .. "bufdo :w")
				elseif input == "no" or input == "n" then
					goto continue
				elseif input == "ignore" or input == "i" then
					opt.force = true
				elseif input == "all" or input == "a" then
					all = true
					vim.cmd("silent " .. bufn .. "bufdo :w")
				elseif input == "cancel" or input == "c" then
					break
				else
					vim.print("\nSelect one of the presented values")
					goto try_again
				end
			end
		end
		vim.api.nvim_buf_delete(bufn, opt)
		::continue::
	end
end, {
	nargs = "*",
	force = true,
	range = true,
	complete = function(_, _)
		local t = {}
		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			table.insert(t, tostring(bufnr))
		end
		return t
	end,
})

-- auto commands --

autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("text_yank_post", { clear = true }),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch" })
	end,
})

vim.api.nvim_create_augroup("tab", { clear = true })

autocmd("FileType", {
	group = "tab",
	pattern = "make",
	callback = function()
		vim.opt.shiftwidth = 4
		vim.opt.tabstop = 4
		vim.opt.expandtab = false
	end,
})

autocmd("FileType", {
	group = "tab",
	pattern = {
		"html",
		"css",
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"json",
		"toml",
		"yaml",
	},
	callback = function()
		vim.opt.shiftwidth = 2
		vim.opt.tabstop = 4
		vim.opt.expandtab = true
	end,
})

autocmd("DirChanged", {
	callback = function()
		local cwd = vim.fn.getcwd()
		local hostname = vim.fn.hostname()
		os.execute('printf "\\033]7;file://' .. hostname .. cwd .. '\\033\\\\"')
	end,
})

