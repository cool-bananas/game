
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

self:add("update_physics", function (id)
  local otherplayer = GameState:get_player1()
  if id == otherplayer then
    otherplayer = GameState:get_player2()
  end

  local player_body = Manager:get_component(id, 'body')
  local otherplayer_body = Manager:get_component(otherplayer, 'body')

  local player_sprite = Manager:get_component(id, 'sprite')
  local otherplayer_sprite = Manager:get_component(id, 'sprite')

  if player_body.physics:get_pos().x < otherplayer_body.physics:get_pos().x then
    player_sprite:set_flip_h(false)
  end

  if player_body.physics:get_pos().x > otherplayer_body.physics:get_pos().x then
    player_sprite:set_flip_h(true)
  end

end)

return self
