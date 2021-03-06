
local Manager = require 'manager'
local Fight = {}

function Fight:init ()
  -- initializer
  self.controller = require 'controller' :new { 'fight' }
  self.elements_id = {}
  self.p1 = false
  self.p2 = false
end

function Fight:get_player1 ()
  return self.p1
end

function Fight:get_player2 ()
  return self.p2
end

function Fight:load ()
  if BattleSetup.arena == 'white' then
    love.graphics.setBackgroundColor(255,255,255)
  end

  self.p1 = Manager:new_element(BattleSetup.p1)
  self.p2 = Manager:new_element(BattleSetup.p2)

  table.insert(self.elements_id, self.p1)
  table.insert(self.elements_id, self.p2)

  self.controller:activate()

  Signal:emit("setup_player", 1, self.p1)
  Signal:emit("setup_player", 2, self.p2)
end

function Fight:update ()
end

function Fight:draw ()
end

function Fight:close ()
  self.controller:deactivate()
end

return Fight
