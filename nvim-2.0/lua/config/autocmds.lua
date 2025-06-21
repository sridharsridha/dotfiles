local M = {}

function M.initial()
  local augroup = vim.api.nvim_create_augroup("user_autocmds", { clear = true })

  -- Remember cursor position
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = augroup,
    pattern = "*",
    callback = function(args)
      local ignore_ft = { "gitcommit", "gitrebase", "svn", "hgcommit" }
      if vim.tbl_contains(ignore_ft, vim.bo[args.buf].filetype) or vim.api.nvim_buf_get_name(args.buf):match("COMMIT_EDITMSG") then
        return
      end

      -- go to last loc when opening a buffer
      local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
      local lcount = vim.api.nvim_buf_line_count(args.buf)
      if mark[1] > 1 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
      end
    end,
  })
end

return M
