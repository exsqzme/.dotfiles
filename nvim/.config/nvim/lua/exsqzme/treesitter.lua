local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "html",
        "css",
        "javascript",
        "lua",
        "markdown",
        "python",
        "rust",
        "scss",
        "toml",
        "tsx",
        "typescript",
        "yaml",
    },
    highlight = {
        enable = true
    }
}
