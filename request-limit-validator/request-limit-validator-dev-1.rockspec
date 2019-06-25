package = "request-limit-validator"
version = "dev-1"
local pluginName = "request-limit-validator"
source = {
   url = "git+ssh://git@github.com/albertjan/kong-setup.git"
}
description = {
   homepage = "https://github.com/Babylonpartners/request-limit-validator",
   license = "WTFPL"
}
dependencies = {
   "lua ~> 5.1",
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.request-limit-validator.handler"] = "handler.lua",
      ["kong.plugins.request-limit-validator.schema"] = "schema.lua"
   }
}
