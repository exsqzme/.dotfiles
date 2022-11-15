local imap = require("exsqzme.utils").imap
local nmap = require("exsqzme.utils").nmap
local telescope_mapper = require("exsqzme.telescope.utils").map_tele

local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
      augroup END
    ]]
  end,

  rust = function()
    telescope_mapper("<space>wf", "lsp_workspace_symbols", {
      ignore_filename = true,
      query = "#",
    }, true)

    -- vim.cmd [[
    --   autocmd BufEnter,BufWritePost <buffer> :lua require('lsp_extensions.inlay_hints').request {aligned = true, prefix = " » "}
    -- ]]

    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.format()
      augroup END
    ]]
  end,
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  nmap(opts)
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  imap(opts)
end

local print_workspace = function()
   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local custom_attach = function(client)
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")

    -- Lsp Saga handles these
    -- buf_nnoremap { "K", vim.lsp.buf.hover }
    -- buf_nnoremap { "<C-k>", vim.lsp.buf.signature_help }
    -- buf_nnoremap { "gD", vim.lsp.buf.declaration }
    -- buf_nnoremap { "gd", vim.lsp.buf.definition }
    -- buf_nnoremap { "<space>rn", vim.lsp.buf.rename }

    buf_nnoremap { "gT", vim.lsp.buf.type_definition }
    -- buf_nnoremap { "gi", vim.lsp.buf.implementation }
    telescope_mapper("gI", "lsp_implementations", nil, true)
    telescope_mapper("gr", "lsp_references", nil, true)
    -- buf_nnoremap { "gr", vim.lsp.buf.references }
    -- telescope_mapper("<space>ca", "lsp_code_actions", nil, true)
    -- https://github.com/nvim-telescope/telescope.nvim/issues/1470
    -- https://github.com/nvim-telescope/telescope.nvim/pull/1866
    buf_nnoremap { "<space>ca", vim.lsp.buf.code_action }
    buf_nnoremap { "<space>f", vim.lsp.buf.format }
    buf_nnoremap { "]d", vim.diagnostic.goto_next }
    buf_nnoremap { "[d", vim.diagnostic.goto_prev }
    buf_nnoremap { "<space>wa", vim.lsp.buf.add_workspace_folder }
    buf_nnoremap { "<space>wr", vim.lsp.buf.remove_workspace_folder }
    buf_nnoremap { "<space>wl", print_workspace }
    buf_nnoremap { "<space>e", vim.diagnostic.open_float }
    buf_nnoremap { "<space>q", vim.diagnostic.setloclist }
    buf_nnoremap { "<space>dl", "<cmd>Telescope diagnostics <cr>" }
    buf_nnoremap { "<space>rr", "LspRestart" }
    telescope_mapper("<space>wd", "lsp_document_symbols", { ignore_filename = true }, true)
    telescope_mapper("<space>ww", "lsp_dynamic_workspace_symbols", { ignore_filename = true }, true)

    buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }


    if filetype ~= "lua" then
        -- buf_nnoremap { "K", vim.lsp.buf.hover, { desc ="lsp:hover" } }
    end

    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    if filetype ~= "dart" then
        -- Set autocommands conditional on server_capabilities
        if client.server_capabilities.documentHighlightProvider then
        -- if client.supports_method('textDocument/documentHighlight') then
        -- if client.server_capabilities.document_highlight then
            vim.cmd [[
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
            ]]
        end
    end

    if client.server_capabilities.codeLensProvider then
        if filetype ~= "elm" then
          vim.cmd [[
            augroup lsp_document_codelens
              au! * <buffer>
              autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
              autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
            augroup END
          ]]
        end
    end

    -- Attach any filetype specific options to the client
    filetype_attach[filetype](client)
end 


-- local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
-- updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)
updated_capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  -- graphql = true,
  html = true,
  pyright = true,
  -- https://github.com/iamcco/vim-language-server
  -- vimls = true,
  eslint = true,

  clangd = true,

  -- Golang
  gopls = {
    root_dir = function(fname)
      local Path = require "plenary.path"

      local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
      local absolute_fname = Path:new(fname):absolute()

      if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        return absolute_cwd
      end

      return lspconfig_util.root_pattern("go.mod", ".git")(fname)
    end,

    settings = {
      gopls = {
        codelenses = { test = true },
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },

  -- .Net
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#omnisharp
  --[[ omnisharp = {
    cmd = { vim.fn.expand "~/build/omnisharp/run", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  }, ]]

  -- Rustlang
  rust_analyzer = {
    -- default {"rust-analyzer"}
    cmd = { "rust-analyzer" },
    -- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = "clippy"
            },
        }
    },
  },
  --   settings = {
  --     ["rust-analyzer"] = {
  --     },
  -- },

  -- Typescript/Javascript/React
  tsserver = {
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },

  -- lua
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
  -- https://github.com/tjdevries/nlua.nvim
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end


return {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
}
