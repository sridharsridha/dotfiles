-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/sridharn/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/sridharn/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/sridharn/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/sridharn/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/sridharn/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    keys = { { "n", "gc" }, { "v", "gc" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["SmoothCursor.nvim"] = {
    config = { "\27LJ\2\nß\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\23disabled_filetypes\1\r\0\0\vaerial\16checkhealth\tfern\flspinfo\nmason\rnerdterm\nnoice\vnotify\17null-ls-info\vpacker\aqf\20TelescopePrompt\nfancy\ttail\1\0\0\thead\1\0\0\1\0\1\venable\2\1\0\4\14intervals\3(\nspeed\3\24\rpriority\3\v\14threshold\3\1\nsetup\17smoothcursor\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/SmoothCursor.nvim",
    url = "https://github.com/gen740/SmoothCursor.nvim"
  },
  ["animation.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/animation.nvim",
    url = "https://github.com/anuvyklack/animation.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-tabnine"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/cmp-tabnine",
    url = "https://github.com/tzachar/cmp-tabnine"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diffview.nvim"] = {
    after = { "neogit" },
    commands = { "Neogit" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["gruvbox.nvim"] = {
    after = { "lualine.nvim" },
    config = { "\27LJ\2\n¨\1\0\0\4\0\f\0\0186\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0009\0\a\0009\0\b\0005\2\t\0005\3\n\0=\3\v\0024\3\0\0B\0\3\1K\0\1\0\targs\1\2\0\0\fgruvbox\1\0\1\bcmd\16colorscheme\rnvim_cmd\bapi\nsetup\fgruvbox\frequire\tdark\15background\6o\bvim\0" },
    loaded = true,
    only_config = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/gruvbox.nvim",
    url = "https://github.com/ellisonleao/gruvbox.nvim"
  },
  ["hop.nvim"] = {
    config = { "\27LJ\2\nw\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\22create_hl_autocmd\1\rquit_key\n<SPC>\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/hop.nvim",
    url = "https://github.com/phaazon/hop.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n≠\1\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\5\25show_current_context\2\28show_first_indent_level\1\19use_treesitter\2\tchar\b‚ñè#show_trailing_blankline_indent\1\nsetup\21indent_blankline\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["lsp-zero.nvim"] = {
    config = { "\27LJ\2\nÀ\6\0\2\t\0$\0v6\2\0\0'\4\1\0B\2\2\0029\2\2\0025\4\3\0005\5\4\0=\5\5\4B\2\2\0015\2\6\0=\1\a\0026\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\f\0006\a\b\0009\a\r\a9\a\14\a9\a\15\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\16\0006\a\b\0009\a\r\a9\a\14\a9\a\17\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\18\0006\a\b\0009\a\r\a9\a\14\a9\a\19\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\20\0006\a\b\0009\a\21\a9\a\22\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\23\0006\a\b\0009\a\21\a9\a\24\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\25\0006\a\b\0009\a\21\a9\a\26\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\27\0006\a\b\0009\a\r\a9\a\14\a9\a\28\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\29\0006\a\b\0009\a\r\a9\a\14\a9\a\30\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\31\0006\a\b\0009\a\r\a9\a\14\a9\a \a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5!\0'\6\"\0006\a\b\0009\a\r\a9\a\14\a9\a#\a\18\b\2\0B\3\5\1K\0\1\0\19signature_help\n<C-h>\6i\vrename\16<leader>vrn\15references\16<leader>vrr\16code_action\16<leader>vca\14goto_prev\a]d\14goto_next\a[d\15open_float\15diagnostic\15<leader>vd\21workspace_symbol\16<leader>vws\nhover\6K\15definition\bbuf\blsp\agd\6n\bset\vkeymap\bvim\vbuffer\1\0\1\nremap\1\17handler_opts\1\0\1\vborder\vsingle\1\0\5\15toggle_key\n<M-x>\ffix_pos\1\vzindex\3c\20floating_window\2\tbind\2\14on_attach\18lsp_signature\frequireD\2\3\t\1\2\0\v\14\0\2\0X\3\1Ä4\2\0\0'\3\1\0=\3\0\2-\3\0\0\18\5\0\0\18\6\1\0\18\a\2\0G\b\3\0C\3\3\0\0¿\frounded\vborder©\2\1\0\5\0\16\0\0256\0\0\0009\0\1\0009\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\2B\0\2\0016\0\0\0009\0\f\0009\0\r\0009\0\14\0006\1\0\0009\1\f\0019\1\r\0013\2\15\0=\2\14\1+\1\2\0002\0\0ÄL\1\2\0\0\26open_floating_preview\tutil\blsp\nfloat\vheader\1\0\1\vborder\frounded\1\3\0\0\16Diagnostics\nTitle\17virtual_text\1\0\1\vprefix\b‚ñé\nsigns\1\0\2\21update_in_insert\2\18severity_sort\2\1\0\1\rpriority\3\t\vconfig\15diagnostic\bvim‚\5\1\0\n\0002\0N6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1Ä2\0FÄ9\2\3\1'\4\4\0B\2\2\0019\2\5\1B\2\1\0019\2\6\1'\4\a\0005\5\15\0005\6\r\0005\a\v\0005\b\t\0005\t\b\0=\t\n\b=\b\f\a=\a\14\6=\6\16\5B\2\3\0016\2\1\0'\4\17\0B\2\2\0025\3\20\0009\4\18\0029\4\19\4=\4\21\0039\4\22\0019\4\23\0045\6\26\0009\a\24\0029\a\25\a\18\t\3\0B\a\2\2=\a\27\0069\a\24\0029\a\28\a\18\t\3\0B\a\2\2=\a\29\0069\a\24\0029\a\30\a5\t\31\0B\a\2\2=\a \0069\a\24\0029\a!\aB\a\1\2=\a\"\6B\4\2\0029\5#\0015\a$\0=\4\24\aB\5\2\0019\5%\0013\a&\0B\5\2\0019\5'\1B\5\1\0016\5(\0009\5)\0059\5*\0055\a+\0B\5\2\0016\5(\0009\5,\0059\5-\5'\a.\0005\b0\0003\t/\0=\t1\bB\5\3\1K\0\1\0K\0\1\0\rcallback\1\0\1\tonce\2\0\rVimEnter\24nvim_create_autocmd\bapi\1\0\1\17virtual_text\2\vconfig\15diagnostic\bvim\nsetup\0\14on_attach\1\0\0\19setup_nvim_cmp\14<C-Space>\rcomplete\n<C-y>\1\0\1\vselect\2\fconfirm\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\17cmp_mappings\rdefaults\rbehavior\1\0\0\vSelect\19SelectBehavior\bcmp\rsettings\1\0\0\bLua\1\0\0\16diagnostics\1\0\0\fglobals\1\0\0\1\2\0\0\bvim\16sumneko_lua\14configure\19nvim_workspace\16recommended\vpreset\rlsp-zero\frequire\npcall\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/lsp-zero.nvim",
    url = "https://github.com/VonHeikemen/lsp-zero.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n¥\5\0\0\a\0!\00056\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\t\0004\4\3\0005\5\6\0005\6\a\0=\6\b\5>\5\1\4=\4\n\0034\4\3\0005\5\v\0>\5\1\0045\5\f\0>\5\2\4=\4\r\0034\4\3\0005\5\14\0>\5\1\0045\5\15\0>\5\2\4=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\0034\4\3\0005\5\21\0005\6\22\0=\6\b\5>\5\1\4=\4\23\3=\3\24\0025\3\28\0004\4\3\0005\5\25\0005\6\26\0=\6\27\5>\5\1\4=\4\n\0034\4\3\0005\5\29\0005\6\30\0=\6\31\5>\5\1\4=\4\23\3=\3 \2B\0\2\1K\0\1\0\ftabline\15tabs_color\1\0\1\vactive\21lualine_b_normal\1\2\0\0\ttabs\1\0\0\18buffers_color\1\0\1\vactive\21lualine_b_normal\1\2\0\0\fbuffers\rsections\14lualine_z\1\0\1\bgui\tbold\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rfiletype\rencoding\15fileformat\14lualine_c\1\2\0\0\16diagnostics\1\2\1\0\rfilename\16file_status\2\14lualine_b\1\2\1\0\tdiff\fcolored\1\1\2\0\0\vbranch\14lualine_a\1\0\0\ncolor\1\0\1\bgui\tbold\1\2\0\0\tmode\foptions\1\0\0\1\0\5\17globalstatus\2\18icons_enabled\2\23section_separators\5\25component_separators\5\ntheme\fgruvbox\nsetup\flualine\frequire\0" },
    load_after = {},
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  middleclass = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/middleclass",
    url = "https://github.com/anuvyklack/middleclass"
  },
  neogit = {
    config = { "\27LJ\2\n¿\1\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\5\0005\4\4\0=\4\6\0035\4\a\0=\4\b\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\17integrations\1\0\1\rdiffview\2\nsigns\titem\1\3\0\0\bÔë†\bÔëº\fsection\1\0\0\1\3\0\0\bÔë†\bÔëº\1\0\1 disable_commit_confirmation\2\nsetup\vneogit\frequire\0" },
    load_after = {
      ["diffview.nvim"] = true
    },
    loaded = false,
    needs_bufread = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["noice.nvim"] = {
    config = { "\27LJ\2\n∞\a\0\0\t\0+\0J6\0\0\0009\0\1\0009\0\2\0004\1\0\0\18\2\0\0'\4\3\0006\5\0\0009\5\1\0059\5\4\5'\a\3\0\18\b\1\0B\5\3\2'\6\5\0&\5\6\5\18\6\1\0B\2\4\1\18\2\0\0'\4\6\0)\5\0\0\18\6\1\0B\2\4\1\18\2\0\0'\4\a\0+\5\1\0\18\6\1\0B\2\4\1\18\2\0\0'\4\b\0+\5\1\0\18\6\1\0B\2\4\0015\2\n\0005\3\t\0=\3\v\0025\3\f\0=\3\r\0026\3\14\0'\5\15\0B\3\2\0029\3\16\0035\5\18\0005\6\17\0=\6\19\0055\6\21\0005\a\20\0=\a\22\0065\a\23\0=\a\24\0065\a\25\0=\2\26\a=\a\27\0065\a\28\0005\b\29\0=\b\30\a=\2\26\a=\a\31\6=\6 \0055\6!\0=\6\"\0055\6$\0005\a#\0=\a%\0065\a&\0=\a'\6=\2\27\6=\6(\5B\3\2\0016\3\14\0'\5)\0B\3\2\0029\3\16\0035\5*\0B\3\2\1K\0\1\0\1\0\4\bfps\3\24\ftimeout\3¨\2\22background_colour\16NormalFloat\vrender\fminimal\vnotify\nviews\16win_options\1\0\1\twrap\1\nsplit\1\0\0\1\0\1\tsize\b25%\fpresets\1\0\5\15inc_rename\1\26long_message_to_split\2\20command_palette\2\18bottom_search\1\19lsp_doc_border\1\blsp\14signature\14auto_open\1\0\1\rthrottle\3(\1\0\2\tview\nhover\fenabled\1\nhover\topts\1\0\2\tview\nhover\fenabled\1\roverride\1\0\0031vim.lsp.util.convert_input_to_markdown_lines\2 cmp.entry.get_documentation\2\"vim.lsp.util.stylize_markdown\2\rprogress\1\0\0\1\0\2\rthrottle\3(\fenabled\2\fcmdline\1\0\0\1\0\1\fenabled\2\nsetup\nnoice\frequire\rposition\1\0\1\brow\3\2\vborder\1\0\0\1\0\1\nstyle\frounded\rshowmode\fshowcmd\14cmdheight\6I\26nvim_get_option_value\14shortmess\26nvim_set_option_value\bapi\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/noice.nvim",
    url = "https://github.com/folke/noice.nvim"
  },
  ["nui.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n…\1\0\0\a\0\n\0\0206\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0029\0\5\0\18\2\0\0009\0\6\0'\3\a\0006\4\0\0'\6\b\0B\4\2\0029\4\t\4B\4\1\0A\0\2\1K\0\1\0\20on_confirm_done\"nvim-autopairs.completion.cmp\17confirm_done\aon\nevent\bcmp\1\0\1\rcheck_ts\2\nsetup\19nvim-autopairs\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-surround"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18nvim-surround\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/nvim-surround",
    url = "https://github.com/kylechui/nvim-surround"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n˘\4\0\0\t\0\27\0.6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1ÄK\0\1\0009\2\3\0015\4\19\0005\5\4\0005\6\5\0004\a\f\0005\b\6\0>\b\1\a5\b\a\0>\b\2\a5\b\b\0>\b\3\a5\b\t\0>\b\4\a5\b\n\0>\b\5\a5\b\v\0>\b\6\a5\b\f\0>\b\a\a5\b\r\0>\b\b\a5\b\14\0>\b\t\a5\b\15\0>\b\n\a5\b\16\0>\b\v\a=\a\17\6=\6\18\5=\5\20\4B\2\2\0016\2\21\0009\2\22\0029\2\23\2'\4\24\0'\5\25\0'\6\26\0B\2\4\1K\0\1\0\28<cmd>NvimTreeToggle<CR>\n<C-n>\6n\bset\vkeymap\bvim\tview\1\0\0\rmappings\tlist\1\0\2\bkey\6y\vaction\14copy_name\1\0\2\bkey\6Y\vaction\14copy_path\1\0\2\bkey\6v\vaction\vvsplit\1\0\2\bkey\6s\vaction\nsplit\1\0\2\bkey\6r\vaction\vrename\1\0\2\bkey\6l\vaction\tedit\1\0\2\bkey\6I\vaction\19toggle_ignored\1\0\2\bkey\6h\vaction\15close_node\1\0\2\bkey\6d\vaction\vremove\1\0\2\bkey\6a\vaction\vcreate\1\0\2\bkey\n<C-R>\vaction\frefresh\1\0\1\16custom_only\2\1\0\4\nwidth\3#\15signcolumn\ano\tside\nright\21hide_root_folder\1\nsetup\14nvim-tree\frequire\npcall\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/nvim-tree/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    after = { "nvim-ts-autotag", "nvim-ts-rainbow", "nvim-ts-context-commentstring" },
    config = { "\27LJ\2\nü\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\2\17auto_install\2\17sync_install\2\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    only_config = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-ts-rainbow"] = {
    config = { "\27LJ\2\nà\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\frainbow\1\0\0\1\0\3\19max_file_lines\3Ë\a\18extended_mode\2\venable\2\nsetup\28nvim-treesitter.configs\frequire\0" },
    load_after = {},
    loaded = true,
    needs_bufread = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n»\t\0\0\b\0$\0I6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1ÄK\0\1\0009\2\3\0015\4\17\0005\5\4\0005\6\6\0005\a\5\0=\a\a\6=\6\b\0055\6\n\0005\a\t\0=\a\v\0065\a\f\0=\a\r\6=\6\14\0055\6\15\0=\6\16\5=\5\18\4B\2\2\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\22\0'\6\23\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\24\0'\6\25\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\26\0'\6\27\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\28\0'\6\29\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\30\0'\6\31\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5 \0'\6!\0B\2\4\0016\2\1\0'\4\2\0B\2\2\0029\2\"\2'\4#\0B\2\2\1K\0\1\0\bfzf\19load_extensionR<cmd>lua require\"telescope.builtin\".git_files({cwd = \"$HOME/.dotfiles\" })<CR>\14<space>fd8<cmd>lua require\"telescope.builtin\".live_grep()<CR>\14<space>fw7<cmd>lua require\"telescope.builtin\".oldfiles()<CR>\14<space>fo8<cmd>lua require\"telescope.builtin\".help_tags()<CR>\14<space>fh2<cmd>Telescope buffers theme=get_dropdown<CR>\14<space>fb9<cmd>lua require\"telescope.builtin\".find_files()<CR>\n<C-p>\bset\vkeymap\bvim\rdefaults\1\0\0\22vimgrep_arguments\1\v\0\0\arg\r--hiddenf--glob=!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db,!node_modules,!bower_components,!*.code-search\18--ignore-case\20--with-filename\18--line-number\r--column\17--no-heading\v--trim\18--color=never\rmappings\6n\1\0\1\n<C-c>\nclose\6i\1\0\0\1\0\3\n<Esc>\nclose\n<C-j>\24move_selection_next\n<C-k>\28move_selection_previous\18layout_config\15horizontal\1\0\0\1\0\1\18preview_width\4\0ÄÄÄˇ\3\1\0\4\18prompt_prefix\n ÔÅî \21sorting_strategy\14ascending\19windowwinblend\3\n\20selection_caret\t‚ùØ \nsetup\14telescope\frequire\npcall\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tmux.nvim"] = {
    config = { "\27LJ\2\nË\1\0\0\4\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\2B\0\2\1K\0\1\0\vresize\1\0\3\18resize_step_x\3\1\31enable_default_keybindings\2\18resize_step_y\3\1\15navigation\1\0\2\31enable_default_keybindings\2\21cycle_navigation\2\14copy_sync\1\0\0\1\0\1\venable\1\nsetup\ttmux\frequire\0" },
    keys = { { "n", "<C-h>" }, { "n", "<C-j>" }, { "n", "<C-k>" }, { "n", "<C-l>" }, { "n", "<A-h>" }, { "n", "<A-j>" }, { "n", "<A-k>" }, { "n", "<A-l>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/opt/tmux.nvim",
    url = "https://github.com/aserowy/tmux.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\nˆ\a\0\0\6\0*\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0005\5\14\0=\5\6\4=\4\15\0035\4\16\0005\5\17\0=\5\6\4=\4\18\0035\4\19\0005\5\20\0=\5\6\4=\4\21\3=\3\22\0025\3\23\0004\4\0\0=\4\24\3=\3\25\0025\3\27\0005\4\26\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\3=\3%\0025\3&\0005\4'\0=\4(\3=\3)\2B\0\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\vcolors\fdefault\1\3\0\0\15Identifier\f#7C3AED\thint\1\3\0\0\30LspDiagnosticsDefaultHint\f#10B981\tinfo\1\3\0\0%LspDiagnosticsDefaultInformation\f#2563EB\fwarning\1\4\0\0!LspDiagnosticsDefaultWarning\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\31LspDiagnosticsDefaultError\rErrorMsg\f#DC2626\14highlight\fexclude\1\0\6\vbefore\5\17max_line_len\3ê\3\nafter\afg\fpattern\22.*<(KEYWORDS)\\s*:\18comments_only\2\fkeyword\twide\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\0\2\ncolor\fwarning\ticon\tÔíê \tTODO\1\0\2\ncolor\tinfo\ticon\tÔÄå \bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ticon\tÔÜà \ncolor\nerror\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\nò\5\0\0\5\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\nsigns\1\0\5\thint\bÔ†µ\nother\bÔ´†\16information\bÔëâ\nerror\bÔôô\fwarning\bÔî©\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\nhover\6K\fpreview\6p\nclose\6q\19toggle_preview\6P\tnext\6j\16toggle_mode\6m\rprevious\6k\vcancel\n<esc>\frefresh\6r\1\0\r\tmode\26workspace_diagnostics\14auto_fold\1\17auto_preview\2\14auto_open\1\17indent_lines\2\25use_diagnostic_signs\2\16fold_closed\bÔë†\15auto_close\1\14fold_open\bÔëº\nwidth\0032\nicons\2\vheight\3\n\rposition\vbottom\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18sri.which-key\frequire\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  },
  ["windows.nvim"] = {
    config = { "\27LJ\2\nå\1\0\0\3\0\b\0\0186\0\0\0009\0\1\0)\1\n\0=\1\2\0006\0\0\0009\0\1\0)\1\n\0=\1\3\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0B\0\1\1K\0\1\0\nsetup\fwindows\frequire\16equalalways\16winminwidth\rwinwidth\6o\bvim\0" },
    loaded = true,
    path = "/Users/sridharn/.local/share/nvim/site/pack/packer/start/windows.nvim",
    url = "https://github.com/anuvyklack/windows.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^neogit"] = "diffview.nvim",
  ["^notify"] = "nvim-notify",
  ["^plenary"] = "plenary.nvim",
  ["nui.*"] = "nui.nvim"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: nvim-surround
time([[Config for nvim-surround]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\18nvim-surround\frequire\0", "config", "nvim-surround")
time([[Config for nvim-surround]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18sri.which-key\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: SmoothCursor.nvim
time([[Config for SmoothCursor.nvim]], true)
try_loadstring("\27LJ\2\nß\2\0\0\5\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\3=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\23disabled_filetypes\1\r\0\0\vaerial\16checkhealth\tfern\flspinfo\nmason\rnerdterm\nnoice\vnotify\17null-ls-info\vpacker\aqf\20TelescopePrompt\nfancy\ttail\1\0\0\thead\1\0\0\1\0\1\venable\2\1\0\4\14intervals\3(\nspeed\3\24\rpriority\3\v\14threshold\3\1\nsetup\17smoothcursor\frequire\0", "config", "SmoothCursor.nvim")
time([[Config for SmoothCursor.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nü\1\0\0\4\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\2B\0\2\1K\0\1\0\vindent\1\0\1\venable\2\14highlight\1\0\2\17auto_install\2\17sync_install\2\1\0\1\venable\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: lsp-zero.nvim
time([[Config for lsp-zero.nvim]], true)
try_loadstring("\27LJ\2\nÀ\6\0\2\t\0$\0v6\2\0\0'\4\1\0B\2\2\0029\2\2\0025\4\3\0005\5\4\0=\5\5\4B\2\2\0015\2\6\0=\1\a\0026\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\f\0006\a\b\0009\a\r\a9\a\14\a9\a\15\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\16\0006\a\b\0009\a\r\a9\a\14\a9\a\17\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\18\0006\a\b\0009\a\r\a9\a\14\a9\a\19\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\20\0006\a\b\0009\a\21\a9\a\22\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\23\0006\a\b\0009\a\21\a9\a\24\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\25\0006\a\b\0009\a\21\a9\a\26\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\27\0006\a\b\0009\a\r\a9\a\14\a9\a\28\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\29\0006\a\b\0009\a\r\a9\a\14\a9\a\30\a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5\v\0'\6\31\0006\a\b\0009\a\r\a9\a\14\a9\a \a\18\b\2\0B\3\5\0016\3\b\0009\3\t\0039\3\n\3'\5!\0'\6\"\0006\a\b\0009\a\r\a9\a\14\a9\a#\a\18\b\2\0B\3\5\1K\0\1\0\19signature_help\n<C-h>\6i\vrename\16<leader>vrn\15references\16<leader>vrr\16code_action\16<leader>vca\14goto_prev\a]d\14goto_next\a[d\15open_float\15diagnostic\15<leader>vd\21workspace_symbol\16<leader>vws\nhover\6K\15definition\bbuf\blsp\agd\6n\bset\vkeymap\bvim\vbuffer\1\0\1\nremap\1\17handler_opts\1\0\1\vborder\vsingle\1\0\5\15toggle_key\n<M-x>\ffix_pos\1\vzindex\3c\20floating_window\2\tbind\2\14on_attach\18lsp_signature\frequireD\2\3\t\1\2\0\v\14\0\2\0X\3\1Ä4\2\0\0'\3\1\0=\3\0\2-\3\0\0\18\5\0\0\18\6\1\0\18\a\2\0G\b\3\0C\3\3\0\0¿\frounded\vborder©\2\1\0\5\0\16\0\0256\0\0\0009\0\1\0009\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\t\0005\4\b\0=\4\n\3=\3\v\2B\0\2\0016\0\0\0009\0\f\0009\0\r\0009\0\14\0006\1\0\0009\1\f\0019\1\r\0013\2\15\0=\2\14\1+\1\2\0002\0\0ÄL\1\2\0\0\26open_floating_preview\tutil\blsp\nfloat\vheader\1\0\1\vborder\frounded\1\3\0\0\16Diagnostics\nTitle\17virtual_text\1\0\1\vprefix\b‚ñé\nsigns\1\0\2\21update_in_insert\2\18severity_sort\2\1\0\1\rpriority\3\t\vconfig\15diagnostic\bvim‚\5\1\0\n\0002\0N6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1Ä2\0FÄ9\2\3\1'\4\4\0B\2\2\0019\2\5\1B\2\1\0019\2\6\1'\4\a\0005\5\15\0005\6\r\0005\a\v\0005\b\t\0005\t\b\0=\t\n\b=\b\f\a=\a\14\6=\6\16\5B\2\3\0016\2\1\0'\4\17\0B\2\2\0025\3\20\0009\4\18\0029\4\19\4=\4\21\0039\4\22\0019\4\23\0045\6\26\0009\a\24\0029\a\25\a\18\t\3\0B\a\2\2=\a\27\0069\a\24\0029\a\28\a\18\t\3\0B\a\2\2=\a\29\0069\a\24\0029\a\30\a5\t\31\0B\a\2\2=\a \0069\a\24\0029\a!\aB\a\1\2=\a\"\6B\4\2\0029\5#\0015\a$\0=\4\24\aB\5\2\0019\5%\0013\a&\0B\5\2\0019\5'\1B\5\1\0016\5(\0009\5)\0059\5*\0055\a+\0B\5\2\0016\5(\0009\5,\0059\5-\5'\a.\0005\b0\0003\t/\0=\t1\bB\5\3\1K\0\1\0K\0\1\0\rcallback\1\0\1\tonce\2\0\rVimEnter\24nvim_create_autocmd\bapi\1\0\1\17virtual_text\2\vconfig\15diagnostic\bvim\nsetup\0\14on_attach\1\0\0\19setup_nvim_cmp\14<C-Space>\rcomplete\n<C-y>\1\0\1\vselect\2\fconfirm\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\17cmp_mappings\rdefaults\rbehavior\1\0\0\vSelect\19SelectBehavior\bcmp\rsettings\1\0\0\bLua\1\0\0\16diagnostics\1\0\0\fglobals\1\0\0\1\2\0\0\bvim\16sumneko_lua\14configure\19nvim_workspace\16recommended\vpreset\rlsp-zero\frequire\npcall\0", "config", "lsp-zero.nvim")
time([[Config for lsp-zero.nvim]], false)
-- Config for: windows.nvim
time([[Config for windows.nvim]], true)
try_loadstring("\27LJ\2\nå\1\0\0\3\0\b\0\0186\0\0\0009\0\1\0)\1\n\0=\1\2\0006\0\0\0009\0\1\0)\1\n\0=\1\3\0006\0\0\0009\0\1\0+\1\1\0=\1\4\0006\0\5\0'\2\6\0B\0\2\0029\0\a\0B\0\1\1K\0\1\0\nsetup\fwindows\frequire\16equalalways\16winminwidth\rwinwidth\6o\bvim\0", "config", "windows.nvim")
time([[Config for windows.nvim]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n˘\4\0\0\t\0\27\0.6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1ÄK\0\1\0009\2\3\0015\4\19\0005\5\4\0005\6\5\0004\a\f\0005\b\6\0>\b\1\a5\b\a\0>\b\2\a5\b\b\0>\b\3\a5\b\t\0>\b\4\a5\b\n\0>\b\5\a5\b\v\0>\b\6\a5\b\f\0>\b\a\a5\b\r\0>\b\b\a5\b\14\0>\b\t\a5\b\15\0>\b\n\a5\b\16\0>\b\v\a=\a\17\6=\6\18\5=\5\20\4B\2\2\0016\2\21\0009\2\22\0029\2\23\2'\4\24\0'\5\25\0'\6\26\0B\2\4\1K\0\1\0\28<cmd>NvimTreeToggle<CR>\n<C-n>\6n\bset\vkeymap\bvim\tview\1\0\0\rmappings\tlist\1\0\2\bkey\6y\vaction\14copy_name\1\0\2\bkey\6Y\vaction\14copy_path\1\0\2\bkey\6v\vaction\vvsplit\1\0\2\bkey\6s\vaction\nsplit\1\0\2\bkey\6r\vaction\vrename\1\0\2\bkey\6l\vaction\tedit\1\0\2\bkey\6I\vaction\19toggle_ignored\1\0\2\bkey\6h\vaction\15close_node\1\0\2\bkey\6d\vaction\vremove\1\0\2\bkey\6a\vaction\vcreate\1\0\2\bkey\n<C-R>\vaction\frefresh\1\0\1\16custom_only\2\1\0\4\nwidth\3#\15signcolumn\ano\tside\nright\21hide_root_folder\1\nsetup\14nvim-tree\frequire\npcall\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\nˆ\a\0\0\6\0*\00016\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\a\0005\4\4\0005\5\5\0=\5\6\4=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0005\5\14\0=\5\6\4=\4\15\0035\4\16\0005\5\17\0=\5\6\4=\4\18\0035\4\19\0005\5\20\0=\5\6\4=\4\21\3=\3\22\0025\3\23\0004\4\0\0=\4\24\3=\3\25\0025\3\27\0005\4\26\0=\4\28\0035\4\29\0=\4\30\0035\4\31\0=\4 \0035\4!\0=\4\"\0035\4#\0=\4$\3=\3%\0025\3&\0005\4'\0=\4(\3=\3)\2B\0\2\1K\0\1\0\vsearch\targs\1\6\0\0\18--color=never\17--no-heading\20--with-filename\18--line-number\r--column\1\0\2\fpattern\18\\b(KEYWORDS):\fcommand\arg\vcolors\fdefault\1\3\0\0\15Identifier\f#7C3AED\thint\1\3\0\0\30LspDiagnosticsDefaultHint\f#10B981\tinfo\1\3\0\0%LspDiagnosticsDefaultInformation\f#2563EB\fwarning\1\4\0\0!LspDiagnosticsDefaultWarning\15WarningMsg\f#FBBF24\nerror\1\0\0\1\4\0\0\31LspDiagnosticsDefaultError\rErrorMsg\f#DC2626\14highlight\fexclude\1\0\6\vbefore\5\17max_line_len\3ê\3\nafter\afg\fpattern\22.*<(KEYWORDS)\\s*:\18comments_only\2\fkeyword\twide\rkeywords\tNOTE\1\2\0\0\tINFO\1\0\2\ticon\tÔ°ß \ncolor\thint\tPERF\1\4\0\0\nOPTIM\16PERFORMANCE\rOPTIMIZE\1\0\1\ticon\tÔôë \tWARN\1\3\0\0\fWARNING\bXXX\1\0\2\ticon\tÔÅ± \ncolor\fwarning\tHACK\1\0\2\ncolor\fwarning\ticon\tÔíê \tTODO\1\0\2\ncolor\tinfo\ticon\tÔÄå \bFIX\1\0\0\balt\1\5\0\0\nFIXME\bBUG\nFIXIT\nISSUE\1\0\2\ticon\tÔÜà \ncolor\nerror\1\0\3\19merge_keywords\2\18sign_priority\3\b\nsigns\2\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: hop.nvim
time([[Config for hop.nvim]], true)
try_loadstring("\27LJ\2\nw\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\3\22create_hl_autocmd\1\rquit_key\n<SPC>\tkeys\28etovxqpdygfblzhckisuran\nsetup\bhop\frequire\0", "config", "hop.nvim")
time([[Config for hop.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: gruvbox.nvim
time([[Config for gruvbox.nvim]], true)
try_loadstring("\27LJ\2\n¨\1\0\0\4\0\f\0\0186\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\0\6\0B\0\1\0016\0\0\0009\0\a\0009\0\b\0005\2\t\0005\3\n\0=\3\v\0024\3\0\0B\0\3\1K\0\1\0\targs\1\2\0\0\fgruvbox\1\0\1\bcmd\16colorscheme\rnvim_cmd\bapi\nsetup\fgruvbox\frequire\tdark\15background\6o\bvim\0", "config", "gruvbox.nvim")
time([[Config for gruvbox.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fdefault\2\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n»\t\0\0\b\0$\0I6\0\0\0006\2\1\0'\3\2\0B\0\3\3\14\0\0\0X\2\1ÄK\0\1\0009\2\3\0015\4\17\0005\5\4\0005\6\6\0005\a\5\0=\a\a\6=\6\b\0055\6\n\0005\a\t\0=\a\v\0065\a\f\0=\a\r\6=\6\14\0055\6\15\0=\6\16\5=\5\18\4B\2\2\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\22\0'\6\23\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\24\0'\6\25\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\26\0'\6\27\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\28\0'\6\29\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5\30\0'\6\31\0B\2\4\0016\2\19\0009\2\20\0029\2\21\2'\4\r\0'\5 \0'\6!\0B\2\4\0016\2\1\0'\4\2\0B\2\2\0029\2\"\2'\4#\0B\2\2\1K\0\1\0\bfzf\19load_extensionR<cmd>lua require\"telescope.builtin\".git_files({cwd = \"$HOME/.dotfiles\" })<CR>\14<space>fd8<cmd>lua require\"telescope.builtin\".live_grep()<CR>\14<space>fw7<cmd>lua require\"telescope.builtin\".oldfiles()<CR>\14<space>fo8<cmd>lua require\"telescope.builtin\".help_tags()<CR>\14<space>fh2<cmd>Telescope buffers theme=get_dropdown<CR>\14<space>fb9<cmd>lua require\"telescope.builtin\".find_files()<CR>\n<C-p>\bset\vkeymap\bvim\rdefaults\1\0\0\22vimgrep_arguments\1\v\0\0\arg\r--hiddenf--glob=!.git,!.svn,!.hg,!CSV,!.DS_Store,!Thumbs.db,!node_modules,!bower_components,!*.code-search\18--ignore-case\20--with-filename\18--line-number\r--column\17--no-heading\v--trim\18--color=never\rmappings\6n\1\0\1\n<C-c>\nclose\6i\1\0\0\1\0\3\n<Esc>\nclose\n<C-j>\24move_selection_next\n<C-k>\28move_selection_previous\18layout_config\15horizontal\1\0\0\1\0\1\18preview_width\4\0ÄÄÄˇ\3\1\0\4\18prompt_prefix\n ÔÅî \21sorting_strategy\14ascending\19windowwinblend\3\n\20selection_caret\t‚ùØ \nsetup\14telescope\frequire\npcall\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\nò\5\0\0\5\0\24\0\0276\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\2B\0\2\1K\0\1\0\nsigns\1\0\5\thint\bÔ†µ\nother\bÔ´†\16information\bÔëâ\nerror\bÔôô\fwarning\bÔî©\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\nhover\6K\fpreview\6p\nclose\6q\19toggle_preview\6P\tnext\6j\16toggle_mode\6m\rprevious\6k\vcancel\n<esc>\frefresh\6r\1\0\r\tmode\26workspace_diagnostics\14auto_fold\1\17auto_preview\2\14auto_open\1\17indent_lines\2\25use_diagnostic_signs\2\16fold_closed\bÔë†\15auto_close\1\14fold_open\bÔëº\nwidth\0032\nicons\2\vheight\3\n\rposition\vbottom\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-ts-rainbow ]]

-- Config for: nvim-ts-rainbow
try_loadstring("\27LJ\2\nà\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\frainbow\1\0\0\1\0\3\19max_file_lines\3Ë\a\18extended_mode\2\venable\2\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-ts-rainbow")

vim.cmd [[ packadd nvim-ts-autotag ]]
vim.cmd [[ packadd nvim-ts-context-commentstring ]]
time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'Neogit', function(cmdargs)
          require('packer.load')({'diffview.nvim'}, { cmd = 'Neogit', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'diffview.nvim'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('Neogit ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[nnoremap <silent> <A-h> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>A-h>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> gc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <A-l> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>A-l>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-j> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>C-j>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-l> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>C-l>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[vnoremap <silent> gc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-h> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>C-h>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <A-k> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>A-k>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <C-k> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>C-k>", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[nnoremap <silent> <A-j> <cmd>lua require("packer.load")({'tmux.nvim'}, { keys = "<lt>A-j>", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufEnter * ++once lua require("packer.load")({'lualine.nvim'}, { event = "BufEnter *" }, _G.packer_plugins)]]
vim.cmd [[au UIEnter * ++once lua require("packer.load")({'noice.nvim'}, { event = "UIEnter *" }, _G.packer_plugins)]]
vim.cmd [[au BufRead * ++once lua require("packer.load")({'indent-blankline.nvim'}, { event = "BufRead *" }, _G.packer_plugins)]]
vim.cmd [[au BufNewFile * ++once lua require("packer.load")({'indent-blankline.nvim'}, { event = "BufNewFile *" }, _G.packer_plugins)]]
vim.cmd [[au InsertEnter * ++once lua require("packer.load")({'nvim-autopairs'}, { event = "InsertEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
