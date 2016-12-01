
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local Physics = require 'physics'

local self = Action.inherit()

local function cancel (atk)
  if atk:get_layer
  Signal:emit("cancel_attack", atk)
  Manager:delete_element(atk)
end

local function parry (atk1, atk2)
  cancel(atk1)
  cancel(atk2)
end

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
  local attacker = Manager:get_component(giver, 'attack')
  local attack = Manager:get_component(receiver, 'attack')
  local actor = Manager:get_component(receiver, 'actor')
  if not attacker or not (attack and actor) then return end

  if actor then
    attacked_actor:take_damage(attacker:get_value())
  elseif attack then
    local receiver_priority = attack:get_priority()
    local giver_priority = attacker:get_priority()
    if receiver_priority == 1 then
      if giver_priority == 1 then
        parry(giver, receiver)
      elseif giver_priority == 2 then
        cancel(receiver)
      end
    elseif receiver_priority == 2 then
      if giver_priority == 2 then
        parry(giver, receiver)
      elseif giver_priority == 3 then
        cancel(receiver)
      end
    elseif receiver_priority == 3 then
      if giver_priority == 3 then
        parry(giver, receiver)
      elseif giver_layer == 1 then
        cancel(receiver)
      end
    end
  end

end)

return self
