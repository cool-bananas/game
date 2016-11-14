
-- boost lua 5.1 functionalities
require 'basic.tableutility'

-- global modules
Signal = require 'basic.signal' :new {}
Input = require 'input'

-- frame info
local framerate = 60
local frameunit = 1/framerate

-- locals
local gamestate = require 'gamestate'
local framedelay = 0

function love.load ()
  -- load modules
  Input.load()
end

function love.udpate (dt)
  -- set fixed framerate
  framedelay = framedelay + dt
  while framedelay >= frameunit do
    framedelay = framedelay - frameunit
    -- update code below

    -- update input module
    Input.update()

    -- update gamestate
    gamestate.update()

  end
end

function love.draw ()
  gamestate.draw()
end

function love.keypressed (key)
  -- check press input for action
  Input.keypressed(key)
end

function love.keyreleased (key)
  -- check release input for action
  Input.keyreleased(key)
end
