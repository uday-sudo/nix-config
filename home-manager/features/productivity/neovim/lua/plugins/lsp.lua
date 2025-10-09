-- lua/plugins/lsp.lua

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- List servers you want to enable
      servers = {
        pyright = {},
        nil_ls = {},
        nixd = {},
        ruff = {},
        clangd = {},
      },
      -- If you need custom setup / adjustments per server:
    --   setup = {
    --     pyright = function(server_opts)
    --     end,
    --     nil_ls = function(server_opts)
    --       server_opts.settings = {
    --         Lua = {
    --           diagnostics = { globals = { "vim" } },
    --           workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    --         },
    --       }
    --     end,
    --     nixd = function(server_opts)
    --     end,
    --     ruff = function(server_opts)
    --     end,
    --   },
    },
  },
}
