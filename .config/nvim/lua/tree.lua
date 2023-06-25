local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    return
end

configs.setup {
  ensure_installed = { 
      "bash",
      "lua", 
      "vim", 
      "vimdoc", 
  },

  sync_install = false,
  auto_install = true,
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { 
            "php", 
            "markdown",
        },
    additional_vim_regex_highlighting = false,
  },
  indent = {
   enable = true,
   disable = { 
            "yaml",
        },
  }, 
}
