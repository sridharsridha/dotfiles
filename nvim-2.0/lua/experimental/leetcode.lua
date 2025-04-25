local leet_arg = "leetcode"
return {
	"kawre/leetcode.nvim",
	lazy = leet_arg ~= vim.fn.argv()[1],
	build = ":TSUpdate html",
	opts = {
		arg = leet_arg,
		lang = "cpp",
		plugins = {
			non_standalone = false,
		},
		injector = {
			-- cpp = {
			-- 	before = { "#include <bits/stdc++.h>", "using namespace std;" },
			-- 	after = "int main() {}",
			-- },
		},
		keys = {
			toggle = { "q" },
			confirm = { "<CR>" },
			reset_testcases = "r",
			use_testcase = "U",
			focus_testcases = "H",
			focus_result = "L",
		},
		theme = {},
		---@see https://github.com/3rd/image.nvim/issues/62
		image_support = false,
	},
	config = function(_, opts)
		require("leetcode").setup(opts)
		vim.keymap.set("n", "<leader>lc", "<cmd>Leet console<cr>", { desc = "Show Leetcode Console" })
		vim.keymap.set("n", "<leader>lr", "<cmd>Leet run<cr>", { desc = "Run Leetcode Test" })
		vim.keymap.set("n", "<leader>ls", "<cmd>Leet submit<cr>", { desc = "Submit Leetcode Solution" })
	end,
}
