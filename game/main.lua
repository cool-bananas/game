
-- boost lua 5.1 functionalities
require 'basic.tableutility'

-- frame info
local framerate = 60
local frameunit = 1/framerate

-- locals
local framedelay = 0

function love.load ()
  -- body...
end

function love.udpate (dt)
  -- set fixed framerate
  framedelay = framedelay + dt
  while framedelay >= frameunit do
    framedelay = framedelay - frameunit
    -- code below


  end
end

function love.draw ()
  -- body...
end
