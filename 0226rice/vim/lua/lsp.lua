-- https://ocaml.org/docs/set-up-editor#using-vimlsp
vim.lsp.config['ocamllsp'] = {
	cmd = { 'ocamllsp' },
	filetypes = {
		'ocaml',
		'ocaml.interface',
		'ocaml.menhir',
		'ocaml.ocamllex',
		'dune',
		'reason'
	},
	root_markers = {
		{ 'dune-project', 'dune-workspace' },
		{ "*.opam", "esy.json", "package.json" },
		'.git'
	},
	settings = {},
}

vim.lsp.enable 'ocamllsp'
vim.lsp.enable 'pyright'
vim.lsp.enable 'clangd'

