-- ╭─────────────────────────────────────────────────────────╮
-- │ Alternate Files Utility                                 │
-- │ Find related files (headers/sources, test files, etc.)  │
-- ╰─────────────────────────────────────────────────────────╯

local M = {}

function M.get_alternate_files()
	local current_file = vim.fn.expand("%:p")
	local alternates = {}

	-- ────────────────────────────────────────────────────
	-- Alternate File Rules
	-- Define patterns for finding related files
	-- ────────────────────────────────────────────────────
	local rules = {
		-- Arista-specific: TAU files and their utilities
		{
			pattern = "/src/(.*)/(.*).tau$",
			target = "/src/%1/ArmPlugin/%2Util.tau",
		},
		{
			pattern = "/src/(.*)/ArmPlugin/(.*)Util.tau$",
			target = "/src/%1/%2.tau",
		},

		-- Standard C/C++ header/source pairs
		{
			pattern = "(.*).h$",
			target = "%1.cpp",
		},
		{
			pattern = "(.*).cpp$",
			target = "%1.h",
		},

		-- Arista-specific: TAC/TIN/ITIN file relationships
		{
			pattern = "(.*).tac$",
			target = { "%1.tin", "%1.itin" }, -- TAC can have both TIN and ITIN
		},
		{
			pattern = "(.*).tin$",
			target = { "%1.tac", "%1.itin" },
		},
		{
			pattern = "(.*).itin$",
			target = { "%1.tac", "%1.tin" },
		},
	}

	-- ────────────────────────────────────────────────────
	-- Process Rules and Find Existing Alternates
	-- ────────────────────────────────────────────────────
	for _, rule in ipairs(rules) do
		if current_file:match(rule.pattern) then
			local function add_alternate(target_template)
				local alternate = current_file:gsub(rule.pattern, target_template)
				-- Only add if file exists and is not the current file
				if vim.fn.filereadable(alternate) == 1 and alternate ~= current_file then
					table.insert(alternates, alternate)
				end
			end

			-- Handle both single and multiple targets
			if type(rule.target) == "table" then
				for _, target_template in ipairs(rule.target) do
					add_alternate(target_template)
				end
			else
				add_alternate(rule.target)
			end
		end
	end

	return alternates
end

return M