return {
	-- vim-test configuration
	{
		"vim-test/vim-test",
		event = "VeryLazy",
		keys = {
			{
				"<leader>t",
				":wa<CR>:TestFile<CR>",
				desc = "Run current test file",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>s",
				":wa<CR>:TestNearest<CR>",
				desc = "Run nearest test",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>l",
				":wa<CR>:TestLast<CR>",
				desc = "Run last test",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>a",
				":wa<CR>:TestSuite<CR>",
				desc = "Run all tests in suite",
				mode = "n",
				noremap = true,
				silent = true,
			},
			{
				"<leader>gt",
				":wa<CR>:TestVisit<CR>",
				desc = "Go to test output",
				mode = "n",
				noremap = true,
				silent = true,
			},
		},
		config = function()
			-- Custom strategy configuration
			vim.cmd([[
                function! NeoSplit(cmd) abort
                  let opts = {'suffix': ' # vim-test'}
                  function! opts.close_terminal()
                    if bufnr(self.suffix) != -1
                      execute 'bdelete!' bufnr(self.suffix)
                    end
                  endfunction

                  call opts.close_terminal()

                  split new

                  call termopen(a:cmd . opts.suffix, opts)
                  au BufDelete <buffer> wincmd p
                  stopinsert
                endfunction

                let g:test#custom_strategies = {'neosplit': function('NeoSplit')}
                let g:test#strategy = 'neosplit'
            ]])
		end,
	},
}
