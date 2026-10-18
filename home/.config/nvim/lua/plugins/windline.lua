return {
    "windwp/windline.nvim",
    config = function()
        require("wlsample.airline")
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "TelescopePrompt", "TelescopeResults", "TelescopePreview" },
            callback = function()
                vim.opt_local.statusline = ""
            end,
        })
    end,
}
