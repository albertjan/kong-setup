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

function RequestLimitValidatorHandler:access(conf)
  RequestLimitValidatorHandler.super.access(self)
  local _, err_uri_args = ngx.req.get_uri_args(conf.allowed_number_query_args)
  local expect100continue = false

  if headers.expect and strip(headers.expect:lower()) == "100-continue" then
    expect100continue = true
  end

  if err_uri_args == "truncated" then
    -- 414 is url too long
    responses.send((expect100continue and 417 or 414), "Too many query parameters!")
  end

  local _, err_post_args = ngx.req.get_post_args(conf.allowed_number_post_args)

  if err_post_args == "truncated" then
    -- 413 is payload too large
    responses.send((expect100continue and 417 or 414), "Too many post parameters!")
  end
end

return RequestLimitValidatorHandler
