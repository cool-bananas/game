
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local self = Action.inherit()

self:add("p1_hold", function (actions)
  if not GameState.__initialized then return end

  local player_id = GameState:get_player1()
  local player_body = Manager:get_component(player_id, 'body')
  local walking_speed = require 'basic.vector' :new { 2, 0 }

  if actions.left and not actions.right then
    player_body.physics:move(-walking_speed)
  elseif actions.right and not actions.left then
    player_body.physics:move(walking_speed)
  end
end)

self:add("p2_hold", function (actions)
  if not GameState.__initialized then return end

  local player_id = GameState:get_player2()
  local player_body = Manager:get_component(player_id, 'body')
  local walking_speed = require 'basic.vector' :new { 2, 0 }

  if actions.left and not actions.right then
    player_body.physics:move(-walking_speed)
  elseif actions.right and not actions.left then
    player_body.physics:move(walking_speed)
  end
end)

return self
