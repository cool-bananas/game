
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

local function setup_hitbox(player, frame)
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
  frame:set_layer(player)
end

self:add ("setup_player", function (player, id)
  local body = Manager:get_component(id, 'body')
  local actor = Manager:get_component(id, 'actor')
  local frame = Manager:get_component(id, 'frame')

  setup_body(player, body)
  setup_lifebar(player, actor)
  setup_hitbox(player, frame)
end)

return self
