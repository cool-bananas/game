
local Model = require 'model'
local Component = require 'component'

local Hitbox = require 'hitbox'
local Vector = require 'basic.vector'
local CollisionLayers = require 'database.collision_layers'

function Frame (params)
  local self = Component.inherit()

  local animations = table.copy(params)
  local current = "default"
  local current_frame = 1
  local timer = Timer:new { Globals.framerate }
  local pos = Vector:new {}

  function self:init()
    for _,anim in pairs(animations) do
      for i,hitboxlist in ipairs(anim.frames) do
        for hitbox in ipairs(hitboxlist) do
          local w, h, ox, oy = table.unpack(hitboxlist[hitbox])
          hitboxlist[hitbox] = Hitbox.new(w, h, ox, oy)
        end
      end
    end
    self:play(current)
  end

  function self:get_animation_frames ()
    return animations[current].frames
  end

  function self:get_animation_size ()
    return #animations[current].frames
  end

  function self:get_animation_step ()
    return animations[current].step
  end

  function self:get_current_frame ()
    return animations[current].frames[current_frame]
  end

  function self:set_layer (layer)
    for _,anim in pairs(animations) do
      for i,hitboxlist in ipairs(anim.frames) do
        for _,hitbox in ipairs(hitboxlist) do
          hitbox:set_layer(layer)
          for __,mask in ipairs(CollisionLayers[layer]) do
            hitbox:set_mask(mask)
          end
        end
      end
    end
  end

  function self:set_animation (anim)
    if anim == current then return end
    if animations[anim] then
      self:play(anim)
    end
  end

  function self:play (anim)
    current = anim
    timer:clear()
    timer:every(
      self:get_animation_step(),
      function ()
        current_frame = current_frame % self:get_animation_size() + 1
      end
    )
  end

  function self:set_position (x, y)
    pos:set(x, y)
  end

  function self:get_position ()
    return pos * 1
  end

  function self:update()
    timer:update()
    for _,collision_area in ipairs(self:get_current_frame()) do
      local x, y = pos:unpack()
      collision_area:set_pos(x, y)
      --print(pos, collision_area:get_pos(), collision_area:get_size())
    end
    Signal:emit("queue_hitboxes", self)
  end

  function self:draw()
    for _,collision_area in ipairs(self:get_current_frame()) do
      local t, r, b, l = collision_area:get_edges()
      love.graphics.setColor(255, 0, 0, 120)
      love.graphics.rectangle( 'fill', l, t, r - l, b - t)
      love.graphics.setColor(255,255,255)
    end
  end

  return self
end

return Model(Frame, 'frame')
