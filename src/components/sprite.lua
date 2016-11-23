
local Model = require 'model'
local Component = require 'component'

function Sprite (params)
  local self = Component.inherit()

  local drawable = {}
  local animations = param.animations or { default = love.newQuad(0, 0, 32, 32, 32, 32) }
  local current_animation = 'default'
  local quad_id = 1

  function self:init ()
    -- image
    drawable[1] = params.image

    -- current quad
    drawable[2] = params.animations[current_animation].quad[quad_id]

    -- position
    drawable[3] = -8000
    drawable[4] = -8000

    -- rotate
    drawable[5] = 0

    -- scale
    drawable[6] = params.scale.x or 1
    drawable[7] = params.scale.y or 1

    -- offset
    drawable[8] = params.animations[current_animation].offset.x
    drawable[9] = params.animations[current_animation].offset.y
  end

  function self:update ()

  end

  function self:draw ()

  end

  return self
end

return Model(Sprite)
