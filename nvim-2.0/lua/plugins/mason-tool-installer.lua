return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		enabled = false,
		cmd = "MasonToolsUpdate",
		dependencies = "williamboman/mason.nvim",
		opts = {
			auto_update = true,
			run_on_start = false,
			ensure_installed = {},
		},
	},
}
