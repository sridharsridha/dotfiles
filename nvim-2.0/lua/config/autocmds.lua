local M = {}

function M.initial()
  local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

  -- Remember cursor position
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    pattern = "*",
    callback = function()
      if vim.bo.filetype == "gitcommit" then
        return
      end
      if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.cmd('normal! g`"')
      end
    end,
  })
end

return M
