
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local Vector = require 'basic.vector'

local self = Action.inherit()

local walking_speed = Vector:new { 1.5, 0 }
local jumping_speed = Vector:new { 0, -60 }

local p1_grounded = true
local p2_grounded = true

self:add("p1_hold", function (actions)
  if not GameState.__initialized then return end

  local player_id = GameState:get_player1()
  local player_body = Manager:get_component(player_id, 'body')

  if actions.left and not actions.right then
    print("left", player_body.physics)
    player_body.physics:move(-walking_speed)
  elseif actions.right and not actions.left then
    print("right", player_body.physics)
    player_body.physics:move(walking_speed)
  end
end)

self:add("p1_press", function (action)
  local player_id = GameState:get_player1()
  local player_body = Manager:get_component(player_id, 'body')
  local size = player_body.physics:get_size()

  if player_body.physics:get_pos().y >= Globals.height - 128 - size.y / 2 then
    p1_grounded = true
  end

  if action == 'up' and p1_grounded then
    player_body.physics:move(jumping_speed)
    p1_grounded = false
  end
end)

self:add("p2_press", function (action)
  local player_id = GameState:get_player2()
  local player_body = Manager:get_component(player_id, 'body')
  local size = player_body.physics:get_size()

  if player_body.physics:get_pos().y >= Globals.height - 128 - size.y / 2 then
    p2_grounded = true
  end

  if action == 'up' and p2_grounded then
    player_body.physics:move(jumping_speed)
    p2_grounded = false
  end
end)

self:add("p2_hold", function (actions)
  if not GameState.__initialized then return end

  local player_id = GameState:get_player2()
  local player_body = Manager:get_component(player_id, 'body')

  if actions.left and not actions.right then
    print("left", player_body.physics)
    player_body.physics:move(-walking_speed)
  elseif actions.right and not actions.left then
    print("right", player_body.physics)
    player_body.physics:move(walking_speed)
  end
end)

return self
