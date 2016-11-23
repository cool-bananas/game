
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local self = Action.inherit()

local walking_speed = require 'basic.vector' :new { 1.5, 0 }
local jumping_speed = require 'basic.vector' :new { 0, -60 }

self:add("p1_hold", function (actions)
  if not GameState.__initialized then return end

  local player_id = GameState:get_player1()
  local player_body = Manager:get_component(player_id, 'body')

  if actions.left and not actions.right then
    player_body.physics:move(-walking_speed)
  elseif actions.right and not actions.left then
    player_body.physics:move(walking_speed)
  end
  if actions.up and player_body.physics:get_speed().y == 0 then
    player_body.physics:move(jumping_speed)
  end
end)

self:add("p2_hold", function (actions)
  if not GameState.__initialized then return end

  local player_id = GameState:get_player2()
  local player_body = Manager:get_component(player_id, 'body')

  if actions.left and not actions.right then
    player_body.physics:move(-walking_speed)
  elseif actions.right and not actions.left then
    player_body.physics:move(walking_speed)
  end
  if actions.up and player_body.physics:get_speed().y == 0 then
    player_body.physics:move(jumping_speed)
  end
end)

return self
