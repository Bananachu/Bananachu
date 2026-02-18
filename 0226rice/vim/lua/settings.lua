-- Theme
-- See https://www.nordtheme.com/
vim.cmd.colorscheme("nord")


-- In order to uses tabs instead of spaces
-- btw here's an objective reason to prefer tabs over spaces :
-- https://www.reddit.com/r/javascript/comments/c8drjo/nobody_talks_about_the_real_reason_to_use_tabs/
vim.cmd([[
	filetype plugin indent on
	set noexpandtab
	set softtabstop=0
]])


-- Specific width for tabs depending on languages
-- (it's only a matter of personnal preferences)
vim.api.nvim_create_augroup("dynamic_tab_width", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "dynamic_tab_width",
	pattern = "*",
	command = "setlocal noexpandtab softtabstop=0",
})
vim.api.nvim_create_autocmd("FileType", {
	group = "dynamic_tab_width",
	pattern = { "ocaml", "html", "vim", "lua" },
	command = "setlocal tabstop=2 shiftwidth=2",
})
vim.api.nvim_create_autocmd("FileType", {
	group = "dynamic_tab_width",
	pattern = { "python", "css", "rust" },
	command = "setlocal tabstop=4 shiftwidth=4",
})
vim.api.nvim_create_autocmd("FileType", {
	group = "dynamic_tab_width",
	pattern = { "c", "sh" },
	command = "setlocal tabstop=8 shiftwidth=8",
})

