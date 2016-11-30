
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local Physics = require 'physics'

local self = Action.inherit()

self:add("update_hitbox", function (id)
  local hitbox = Manager:get_component(id, 'hitbox')
  print(hitbox)
  Physics.enqueue(hitbox)
end)

self:add("model_update_done", function (model)
  if not model == 'hitbox' then return end
  Physics.collide()
end)

self:add("update_physics", function (id)
  local body = Manager:get_component(id, 'body')
  local hitbox = Manager:get_component(id, 'hitbox')
  if not body or not hitbox then return end
  hitbox:set_position(body.physics:get_pos():unpack())
end)

self:add("collide", function (id)

end)

return self
