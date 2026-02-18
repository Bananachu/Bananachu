-- Quitting terminal split with <Esc>
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })


-- y and yy add text to OS clipboard
vim.keymap.set("v", "y", '"+y:let @0=@+<CR>', { noremap = true, silent = true, expr = false })
vim.keymap.set("n", "yy", '"+yy:let @0=@+<CR>', { noremap = true, silent = true, expr = false })


-- Launch <file> in <program> (see below)
local function RunProgramWithFile(program, file)
	if program == "utop" then
		-- Utop does not provide a simple way to launch a file at startup, here we
		-- make a temporary config file telling it to do so.
		local temp_init = "/tmp/utop_init.ml"
		vim.fn.writefile({ '#use "' .. file .. '";;' }, temp_init)
		vim.cmd("rightbelow vsplit | terminal utop -init " .. temp_init)
		vim.cmd("startinsert")
	elseif program == "clang" then
		-- For C and C++ files we must compile them first and then execute the
		-- binary which is put in /tmp in order to not overwrite anything in wd.
		local name = vim.fn.expand("%:r")
		vim.cmd(
			"rightbelow vsplit | terminal clang -o /tmp/"
			.. vim.fn.shellescape(name) -- file name minus extension
			.. " "
			.. vim.fn.shellescape(file)
			.. "; /tmp/"
			.. name
		)
		vim.cmd("startinsert")
	else
		-- In most cases, doing <program> <file> in terminal does the job.
		vim.cmd("rightbelow vsplit | terminal " .. vim.fn.shellescape(program) .. " " .. vim.fn.shellescape(file))
		vim.cmd("startinsert")
	end
end

-- Autocommandes pour lier <Ctrl+Enter> selon le type de fichier
vim.api.nvim_create_augroup("programs_launcher", { clear = true })

local mappings = {
	ocaml = "utop",
	python = "python3",
	javascript = "node",
	markdown = "glow",
	c = "clang",
}

for ft, prog in pairs(mappings) do
	vim.api.nvim_create_autocmd("FileType", {
		group = "programs_launcher",
		pattern = ft,
		callback = function()
			vim.keymap.set(
				"n",
				"<C-CR>",
				function() RunProgramWithFile(prog, vim.fn.expand("%:p")) end,
				{ buffer = true, noremap = true, silent = true }
			)
		end,
	})
end
