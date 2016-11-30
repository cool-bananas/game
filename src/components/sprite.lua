
local Model = require 'model'
local Component = require 'component'

function Sprite (params)
  local self = Component.inherit()

  local drawable = {}
  local animations = params.animations or {
    default = {
      frames = { love.graphics.newQuad(0, 0, 32, 32, 32, 32) },
      step = 0.1,
      offset = { x = 0, y = 0 },
      oneshot = false,
    }
  }
  local current_animation = 'default'
  local quad_id = 1
  local timer = Timer:new { framerate = Globals.framerate }

  function self:init ()
    -- image
    drawable[1] = params.image

    -- current quad
    drawable[2] = self:get_current_frame()

    -- position
    drawable[3] = -8000
    drawable[4] = -8000

    -- rotate
    drawable[5] = 0

    -- scale
    drawable[6] = params.scale.x or 1
    drawable[7] = params.scale.y or 1

    -- offset
    drawable[8] = self:get_offset().x
    drawable[9] = self:get_offset().y

    self:set_animation(current_animation)
  end

  function self:set_position (pos)
    drawable[3], drawable[4] = pos:unpack()
  end

  function self:get_current_frame ()
    return animations[current_animation].frames[quad_id]
  end

  function self:get_offset ()
    return animations[current_animation].offset
  end

  function self:get_step ()
    return animations[current_animation].step
  end

  function self:get_number_of_frames ()
    return #animations[current_animation].frames
  end

  function self:next_frame ()
    quad_id = quad_id % self:get_number_of_frames() + 1
  end

  function self:set_animation (aname)
    -- if animation does not exist, then stop all animations
    if not animations[aname] then
      self:stop_animation()
      return
    end

    -- if animation is already in action, then do nothing
    if current_animation == aname and playing then return end

    -- set and play current animation
    current_animation = aname
    self:play_animation()
  end

  function self:play_animation ()
    if animations[current_animation].oneshot then
      timer:every(
        self:get_step(),
        function ()
          self:next_frame()
        end,
        self:get_number_of_frames() - 1
      )
    else
      timer:every(
        self:get_step(),
        function ()
          self:next_frame()
        end
      )
    end
  end

  function self:stop_animation ()
    timer:clear()
  end

  function self:set_flip_h (flipped)
    if flipped then
      drawable[6] = -params.scale.x
    else
      drawable[6] = params.scale.x
    end
  end

  function self:update ()
    timer:update()
    drawable[2] = self:get_current_frame()
    drawable[8] = self:get_offset().x
    drawable[9] = self:get_offset().y
  end

  function self:draw ()
    love.graphics.draw(table.unpack(drawable))
  end

  print("new sprite", self)
  return self
end

return Model(Sprite, 'sprite')
