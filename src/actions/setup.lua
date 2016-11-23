
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
  local offset, pos
  if player == 1 then
    offset = -150
  elseif player == 2 then
    offset = 150
  end
  pos = Vector:new {Globals.width / 2 + offset, 50}

  -- create new element that synchronizes with player's actor below
  -- [code here]
end

self:add ("setup_player", function (player, id)
  local body = Manager:get_component(id, 'body')
  setup_body(player, body)
end)

return self
