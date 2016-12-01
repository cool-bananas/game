
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local Vector = require 'basic.vector'

local self = Action.inherit()

local function setup_body(player, body)
  if player == 1 then
    body.physics:set_pos(100, Globals.height - 128)
  elseif player == 2 then
    body.physics:set_pos(Globals.width - 100, Globals.height - 128)
  end
end

local function setup_lifebar (player, actor)
  local offset = 200
  local pos

  if player == 1 then
    offset = -1 * offset
  end
  pos = Vector:new {Globals.width / 2 + offset, 50}

  -- create new element that synchronizes with player's actor below
  local lifebar_id = Manager:new_element('lifebar')
  local lifebar = Manager:get_component(lifebar_id, 'lifebar')
  lifebar:set_pos(pos:unpack())
  lifebar:set_actor(actor)
end

local function setup_hitbox(player, hitbox)
  --[[

  HITBOX LAYERS
  1: player one
  2: player two
  3: hits from one weak
  4: hits from one strong
  5: hits from one bullet
  6: hits from two weak
  7: hits from two strong
  8: hits from two bullet

  ]]
  if player == 1 then
    hitbox:get_collision_area():set_layer(1)
    hitbox:get_collision_area():set_mask(2)
    hitbox:get_collision_area():set_mask(6)
    hitbox:get_collision_area():set_mask(7)
    hitbox:get_collision_area():set_mask(8)
  elseif player == 2 then
    hitbox:get_collision_area():set_layer(2)
    --hitbox:get_collision_area():set_mask(1)
    hitbox:get_collision_area():set_mask(3)
    hitbox:get_collision_area():set_mask(4)
    hitbox:get_collision_area():set_mask(5)
  end
end

self:add ("setup_player", function (player, id)
  local body = Manager:get_component(id, 'body')
  local actor = Manager:get_component(id, 'actor')
  local hitbox = Manager:get_component(id, 'hitbox')

  setup_hitbox(player, hitbox)
  setup_body(player, body)
  setup_lifebar(player, actor)
end)

return self
