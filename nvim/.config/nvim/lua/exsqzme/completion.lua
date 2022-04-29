-- setup nvim cmp (autocomplete)
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.close(),
      ["<c-y>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        { "i", "c" }
      ),

      ["<c-space>"] = cmp.mapping {
        i = cmp.mapping.complete(),
        c = function(
          _ --[[fallback]]
        )
          if cmp.visible() then
            if not cmp.confirm { select = true } then
              return
            end
          else
            cmp.complete()
          end
        end,
      },

      -- ["<tab>"] = false,
      ["<tab>"] = cmp.config.disable,

      -- ["<tab>"] = cmp.mapping {
      --   i = cmp.config.disable,
      --   c = function(fallback)
      --     fallback()
      --   end,
      -- },

      -- Testing
      ["<c-q>"] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },

      -- If you want tab completion :'(
      --  First you have to just prmise to read `:help ins-completion`.
      --
      -- ["<Tab>"] = function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   else
      --     fallback()
      --   end
      -- end,
      -- ["<S-Tab>"] = function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   else
      --     fallback()
      --   end
      -- end,
    },

    -- Youtube:
    --    the order of your sources matter (by default). That gives them priority
    --    you can configure:
    --        keyword_length
    --        priority
    --        max_item_count
    --        (more?)o
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer', keyword_length = 5 },
    }),

    -- TODO: FROM ME: Do I need this?
    sorting = {
    -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
        comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,

            -- copied from cmp-under, but I don't think I need the plugin for this.
            -- I might add some more of my own.
            function(entry1, entry2)
                local _, entry1_under = entry1.completion_item.label:find "^_+"
                local _, entry2_under = entry2.completion_item.label:find "^_+"
                entry1_under = entry1_under or 0
                entry2_under = entry2_under or 0
                if entry1_under > entry2_under then
                  return false
                elseif entry1_under < entry2_under then
                  return true
                end
            end,

            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },

    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- for luasnip users
        end,
    },

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
            },
        },
    },

    experimental = {
        --native_menu = false
        ghost_text = true
    },
})
