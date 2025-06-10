local M = {}

function M.get_alternate_files()
  local current_file = vim.fn.expand("%:p")
  local alternates = {}

  local rules = {
    {
      pattern = "/src/(.*)/(.*).tau$",
      target = "/src/%1/ArmPlugin/%2Util.tau",
    },
    {
      pattern = "/src/(.*)/ArmPlugin/(.*)Util.tau$",
      target = "/src/%1/%2.tau",
    },
    {
      pattern = "(.*).h$",
      target = "%1.cpp",
    },
    {
      pattern = "(.*).cpp$",
      target = "%1.h",
    },
    {
      pattern = "(.*).tac$",
      target = { "%1.tin", "%1.itin" },
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

  for _, rule in ipairs(rules) do
    if current_file:match(rule.pattern) then
      local function add_alternate(target_template)
        local alternate = current_file:gsub(rule.pattern, target_template)
        if vim.fn.filereadable(alternate) == 1 and alternate ~= current_file then
          table.insert(alternates, alternate)
        end
      end

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