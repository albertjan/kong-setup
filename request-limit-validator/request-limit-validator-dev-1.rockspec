package = "request-limit-validator"
version = "dev-1"
source = {
   url = "git+ssh://git@github.com/albertjan/kong-setup.git"
}
description = {
   homepage = "*** please enter a project homepage ***",
   license = "*** please specify a license ***"
}
build = {
   type = "builtin",
   modules = {
      handler = "handler.lua",
      schema = "schema.lua"
   }
}
