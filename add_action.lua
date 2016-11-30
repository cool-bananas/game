--[[

This file is independent from the game. You do not need it for it to run.

Run this with:

>> lua add_action.lua [action name] [gamestate to which it belongs]

It should write the basic code for the action automatically.
For more information on actions, refer to `src/actions/readme.md`

]]

local args = { ... }

if not args[1] or not args[2] then
  print("No arguments given. Usage:")
  print(">> lua add_action.lua [action name] [gamestate name]")
  return
end

local name = args[1]
local gamestate = args[2]

local file
local filestring

print("opening database registry...")
file = io.open( "src/database/actions.lua", "r" )
filestring = file:read('*all')
file:close()

if not filestring:find("'" .. name .. "'") then
  if not filestring:find(gamestate .. " = {") then
    print("adding `" .. gamestate .. "` section...")
    filestring = filestring:gsub("},", "},\n  " .. gamestate .. " = {\n  },")
  end

  print("rewriting database registry...")
  filestring = filestring:gsub(gamestate .. " = {", gamestate .. " = {\n    '" .. name .. "',")

  print("saving database registry...")
  file = io.open( "src/database/actions.lua", "w+" )
  file:write( filestring )
  file:close()
else
  print("action already registered!")
end

print("creating action file...")
filestring = [[

local Manager = require 'manager'
local GameState = require 'gamestate'.current()
local Action = require 'action'

local self = Action.inherit()

-- Register signals here! Like this:
-- self:add("signal", function (...) end)

return self
]]

file = io.open( "src/actions/" .. name .. ".lua", "w+" )
file:write( filestring )
file:close()
