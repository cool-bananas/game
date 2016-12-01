
local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local self = Action.inherit()

print("\nATTACK CONTROLLER ACTIVATED\n")

local function weak_attack (player, player_id)
  print("WEAK ATTACK!", player)
  --
end

local function strong_attack (player, player_id)
  print("STRONG ATTACK!", player)
  --
end

local function bullet_attack (player, player_id)
  print("BULLET ATTACK!", player)
  --
end

self:add("p1_press", function (action)
  local player_id = GameState:get_player1()
  if     action == 'A' then
    weak_attack(1, player_id)
  elseif action == 'B' then
    strong_attack(1, player_id)
  elseif action == 'C' then
    bullet_attack(1, player_id)
  end
end)

self:add("p2_press", function (action)
  local player_id = GameState:get_player2()
  if     action == 'A' then
    weak_attack(2, player_id)
  elseif action == 'B' then
    strong_attack(2, player_id)
  elseif action == 'C' then
    bullet_attack(2, player_id)
  end
end)

return self
