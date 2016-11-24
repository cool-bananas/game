
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

self:add ("setup_player", function (player, id)
  local body = Manager:get_component(id, 'body')
  local actor = Manager:get_component(id, 'actor')

  setup_body(player, body)
  setup_lifebar(player, actor)
end)

return self
