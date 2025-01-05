require('nixCatsUtils').setup {
  non_nix_value = true,
}
require 'myLuaConf.non_nix_download'
--[[
(
  the help for this feature is at :h nixCats.luaUtils and the kickstart-nvim template at
  nix flake init -t github:BirdeeHub/nixCats-nvim#kickstart-nvim
)
--]]
require 'myLuaConf'
