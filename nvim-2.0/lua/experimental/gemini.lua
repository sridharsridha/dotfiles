return {
   {
      'kiddos/gemini.nvim',
      dependencies = {
         'MunifTanjim/nui.nvim',
      },
      lazy = false,
      config = function()
         require('gemini').setup({
            -- Your custom configuration goes here
         })
      end,
   },
}
