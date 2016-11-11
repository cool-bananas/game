
-- boost lua 5.1 functionalities
require 'basic.tableutility'

-- global modules
Signal = require 'basic.signal' :new {}

-- frame info
local framerate = 60
local frameunit = 1/framerate

-- locals
local framedelay = 0

-- local modules
local input = require 'input'

function love.load ()
  -- body...
  input.load()
end

function love.udpate (dt)
  -- set fixed framerate
  framedelay = framedelay + dt
  while framedelay >= frameunit do
    framedelay = framedelay - frameunit
    -- update code below
    input.update()


  end
end

function love.draw ()
  -- body...
end

function love.keypressed (key)
  input.keypressed(key)
end

function love.keyreleased (key)
  input.keyreleased(key)
end
