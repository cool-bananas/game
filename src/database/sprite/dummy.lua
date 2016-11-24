
local dummy = {}

dummy.image = love.graphics.newImage('assets/img/dummy.png')

dummy.width = dummy.image:getWidth()
dummy.height = dummy.image:getHeight()

dummy.scale = {
  x = 2,
  y = 2,
}

dummy.animations = {
  default = {
    oneshot = false,
    offset = {
      x = 48,
      y = 96,
    },
    frames = {
      love.graphics.newQuad(0 * 96, 0, 96, 96, dummy.width, dummy.height),
      love.graphics.newQuad(1 * 96, 0, 96, 96, dummy.width, dummy.height),
      love.graphics.newQuad(2 * 96, 0, 96, 96, dummy.width, dummy.height),
      love.graphics.newQuad(1 * 96, 0, 96, 96, dummy.width, dummy.height),
    },
    step = .15,
  },
  walking = {
    offset = {
      x = 48,
      y = 96,
    },
    frames = {
      love.graphics.newQuad(0 * 96, 96, 96, 96, dummy.width, dummy.height),
      love.graphics.newQuad(1 * 96, 96, 96, 96, dummy.width, dummy.height),
      love.graphics.newQuad(2 * 96, 96, 96, 96, dummy.width, dummy.height),
      love.graphics.newQuad(1 * 96, 96, 96, 96, dummy.width, dummy.height),
    },
    step = .15,
  },
}

return dummy
