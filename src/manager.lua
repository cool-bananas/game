
local manager = require 'basic.prototype' :new {
  __type = 'manager'
}

local Components = require 'basic.pack' 'components'
local component_list = require 'database.components'
local IDManager = require 'basic.unique'

function manager:__init ()
  self.elements = {}
  for i, cname in ipairs(component_list) do
    print("loading...", cname, Components[cname])
  end
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

function manager:get_component (id, cname)
  return Components[cname].get(id)
end

function manager:new_element (element_name)
  local id = IDManager:generate()
  for i,component_name in ipairs(component_list) do
    print("set component", component_name)
    local success, params = pcall(require, 'database.' .. component_name .. '.' .. element_name)
    if success then
      Components[component_name].create(id, params)
    else
      -- for debugging, this is very useful
      print(params)
    end
  end
  return id
end

return manager:new {}
