vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")

require("lazy").setup({
	"tpope/vim-sensible",
	"shaunsingh/nord.nvim",
	"neovim/nvim-lspconfig",
})

