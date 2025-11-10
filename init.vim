" Plugins
call plug#begin()
Plug "tpope/vim-sensible"
Plug "shaunsingh/nord.nvim"
call plug#end()

" Color theme
colorscheme nord

" To return to normal mode in a terminal window the same way as in text winwow
tnoremap <Esc> <C-\><C-n>

" Merge nvim clipboard to OS one
vnoremap y "+y:let @0=@+<CR>
nnoremap yy "+yy:let @0=@+<CR>

" Set \t as default when pressing <TAB>
filetype plugin indent on
set noexpandtab
set softtabstop=0

" Variable tab width depending on language
augroup dynamic_tab_width
	autocmd!
	autocmd FileType * setlocal noexpandtab softtabstop=0
	autocmd FileType {ocaml,html,vim,lua} setlocal tabstop=2 shiftwidth=2
	autocmd FileType {python,css,rust} setlocal tabstop=4 shiftwidth=4
	autocmd FileType {c,sh} setlocal tabstop=8 shiftwidth=8
augroup END

" Launch dedicated program for some specific file types with <Ctrl+Enter>
augroup programs_launcher
	autocmd!
	autocmd FileType ocaml nnoremap <buffer> <C-CR> :call RunProgramWithFile("utop", expand("%:p"))<CR>
	autocmd FileType python nnoremap <buffer> <C-CR> :call RunProgramWithFile("python3", expand("%:p"))<CR>
	autocmd FileType javascript nnoremap <buffer> <C-CR> :call RunProgramWithFile("node", expand("%:p"))<CR>
	autocmd FileType markdown nnoremap <buffer> <C-CR> :call RunProgramWithFile("glow", expand("%:p"))<CR>
	autocmd FileType c nnoremap <buffer> <C-CR> :call RunProgramWithFile("gcc", expand("%:p"))<CR>
augroup END

function RunProgramWithFile(program, file)
	if a:program ==# "utop"
		" The only way to load a file at startup in utop is to add a
		" special command in an init file which we make in /tmp
		let l:temp_init = "/tmp/utop_init.ml"
    call writefile(["#use \"" . a:file . "\";;"], l:temp_init)
		execute "rightbelow vsplit | terminal utop -init " . l:temp_init
		startinsert
	elseif a:program ==# "gcc"
		" Compile code into a file whose name is current file without
		" extension then execute the binary.
    let l:name = expand("%:r")
    execute "rightbelow vsplit | terminal gcc -o " . shellescape(l:name) . " " .shellescape(a:file) . "; ./" . l:name
		startinsert
	else
		" Same as '<program> <file>' in terminal
    execute "rightbelow vsplit | terminal " .shellescape(a:program) . " " .shellescape(a:file)
		startinsert
	endif
endfunction
