
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local self = Action.inherit()

local G = require 'basic.vector' :new { 0, 6 }

self:add("update_physics", function (id)
  if not GameState.__initialized then return end

  local player_body = Manager:get_component(id, 'body')

  player_body.physics:move(G)
end)

return self
