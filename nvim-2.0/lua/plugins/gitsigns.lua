return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
            signs_staged_enable = true,
				current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Next Hunk" })

					map("n", "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, desc = "Prev Hunk" })

					-- Actions
					map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, { desc = "Stage Hunk" })
					map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, { desc = "Reset Hunk" })
					map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
					map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
					map("n", "<leader>ghb", function()
						gs.blame_line({ full = true })
					end, { desc = "Blame Line" })
					map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
					map("n", "<leader>ghD", function()
						gs.diffthis("~")
					end, { desc = "Diff This ~" })
					map('n', '<leader>ghw', gs.toggle_word_diff)
					map("n", "<leader>ght", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
				end,
			})
		end,
	},
}
