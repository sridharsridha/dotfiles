return {
	{
		"echasnovski/mini.surround",
		event = "InsertEnter",
		opts = {
			search_method = "cover_or_next",
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				add = "gs",
				delete = "ds",
				replace = "cs",
				find = "", -- Find surrounding (to the right)
				find_left = "", -- Find surrounding (to the left)
				highlight = "", -- Highlight surrounding
				update_n_lines = "", -- Update `n_lines`
				suffix_last = "", -- Suffix to search with "prev" method
				suffix_next = "", -- Suffix to search with "next" method
			},
		},
	},
}
