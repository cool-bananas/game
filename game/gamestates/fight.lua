
local Manager = require 'manager'
local Fight = {}

function Fight:init ()
  -- initializer
  self.elements_id = {}
end

function Fight:load ()
  table.insert(self.elements_id, Manager:new_element('dummy'))
end

function Fight:update ()
end

function Fight:draw ()
end

function Fight:close ()
end

return Fight
