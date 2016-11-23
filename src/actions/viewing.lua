
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local self = Action.inherit()

self:add("physics_done", function (id)
  if not GameState.__initialized then return end

  local player_body = Manager:get_component(id, 'body')
  local player_sprite = Manager:get_component(id, 'sprite')

  player_sprite:set_position(player_body.physics:get_pos())

end)

return self
