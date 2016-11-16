
local manager = require 'basic.prototype' :new {
  __type = 'manager'
}

local Components = require 'basic.pack' 'components'
local component_list = require 'database.components'
local IDManager = require 'basic.unique'

function manager:__init ()
  self.elements = {}
end

function manager:update ()
  for i, cname in ipairs(component_list) do
    Components[cname]:update()
  end
end

function manager:draw ()
  for i, cname in ipairs(component_list) do
    Components[cname]:draw()
  end
end

function manager:new_element (name)
  local id = IDManager:generate()
  for _,cname in ipairs(component_list) do
    local success, params = pcall(require, 'database.' .. cname .. '.' .. name)
    if success then
      Components[cname].create(id, params)
    else
      print(params)
    end
  end
end

return manager:new {}
