--[[

This file is independent from the game. You do not need it for it to run.

Run this with:

>> lua add_component.lua [component name]

It should write the basic code for the component automatically.
For more information on components, refer to `src/components/readme.md`

]]

local args = { ... }

if not args[1] then
  print("No arguments given. Usage:")
  print(">> lua add_component.lua [component name]")
  return
end

local name = args[1]

local capitalized = name:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
local file
local filestring

print("creating folder...")
print("> src/database/" .. name)
os.execute('mkdir src/database/' .. name)

print("opening database registry...")
file = io.open( "src/database/components.lua", "r" )
filestring = file:read('*all')
file:close()

if not filestring:find("'" .. name .. "'") then
  print("rewriting database registry...")
  filestring = filestring:gsub("}", "  '" .. name .. "',\n}")

  print("saving database registry...")
  file = io.open( "src/database/components.lua", "w+" )
  file:write( filestring )
  file:close()
else
  print("component already registered!")
end

print("creating component file...")
filestring = [[

local Model = require 'model'
local Component = require 'component'

function ]] .. capitalized .. [[ (params)
  local self = Component.inherit()

  -- add attributes here, like this:

  -- self.public_attribute = "foo"
  -- local private_attribute = "bar"

  function self:init()
    -- initializer
  end

  function self:update()
    -- update
  end

  function self:draw()
    -- draw
  end

  -- add your own methods too!

  return self
end

return Model(]] .. capitalized .. [[, ']] .. name .. [[')
]]

file = io.open( "src/components/" .. name .. ".lua", "w+" )
file:write( filestring )
file:close()
