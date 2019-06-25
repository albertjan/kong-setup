-- Copyright (C) Babylon Health.

local BasePlugin = require "kong.plugins.base_plugin"
local responses = require "kong.tools.responses"
local strip = require("pl.stringx").strip
local tonumber = tonumber

local RequestLimitValidatorHandler = BasePlugin:extend()

RequestLimitValidatorHandler.PRIORITY = 951
RequestLimitValidatorHandler.VERSION = "0.1.0"

function RequestLimitValidatorHandler:new()
  RequestLimitValidatorHandler.super.new(self, "request-size-limiting")
end

function countArgs(table)
  local cur = 0
  for k, v in ipairs(table) do
    if type(v) == "table" then
      cur = cur + #v
    else
      cur = cur + 1
    end
  end
  return cur
end

function RequestLimitValidatorHandler:access(conf)
  RequestLimitValidatorHandler.super.access(self)
  local args, err_uri_args = ngx.req.get_uri_args(conf.allowed_number_query_args + 1)
  local expect100continue = false
  local headers = ngx.req.get_headers()

  if headers.expect and strip(headers.expect:lower()) == "100-continue" then
    expect100continue = true
  end


  if countArgs(args) == 101 then
    -- 414 is url too long
    responses.send((expect100continue and 417 or 414), "Too many query parameters!")
  end

  if headers["content-type"] == "application/x-www-form-urlencoded" then
    ngx.req.read_body()
    local args, err_post_args = ngx.req.get_post_args(conf.allowed_number_post_args + 1)

    if countArgs(args) == 101 then
      -- 413 is payload too large
      responses.send((expect100continue and 417 or 414), "Too many post parameters!")
    end
  end
end

return RequestLimitValidatorHandler
