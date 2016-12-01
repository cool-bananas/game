
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local Physics = require 'physics'

local self = Action.inherit()

self:add("queue_hitboxes", function (frame)
  Physics.enqueue(frame)
end)

self:add("model_update_done", function (model)
  if not model == 'hitbox' then return end
  Physics.collide()
end)

self:add("physics_done", function (id)
  local body = Manager:get_component(id, 'body')
  local frame = Manager:get_component(id, 'frame')
  if not body or not frame then return end
  frame:set_position(body.physics:get_pos():unpack())
end)

self:add("collide", function (receiver, giver)
  print("COLLISION", receiver, giver)
end)

return self
