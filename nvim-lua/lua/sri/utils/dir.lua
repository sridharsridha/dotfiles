local fn = vim.fn
local Util = {}

-- Create a folder
function Util.mkdir(dir)
	if fn.isdirectory(dir) == 0 then
		fn.mkdir(dir, 'p')
	end
	return dir
end

return Util
