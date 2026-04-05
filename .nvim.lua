local hostname = 'wkst'
local getFlake = '(builtins.getFlake (toString ./.))'

---@type vim.lsp.Config
local nixd_config = {
  settings = {
    nixd = {
      options = {
        nixos = {
          expr = getFlake .. '.nixosConfigurations.' .. hostname .. '.options',
        },
      },
    },
  },
}

vim.lsp.config('nixd', nixd_config)
