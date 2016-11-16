
local manager = require 'manager'


local fight = {}

function fight:init ()
  manager:new_element('dummy')
end

function fight:load ()
  -- body...
end

function fight:update ()
  -- body...
end

function fight:draw ()
  -- body...
end

function fight:close ()
  -- body...
end

return fight
