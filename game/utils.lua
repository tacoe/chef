local Base = require "lib/knife/base"

utils = Base.extend({
  mi_x = 0,
  mi_y = 0,
  })

function utils:update_dev_hud()
  if love.keyboard.isDown('left') then
    self.mi_x = self.mi_x - 10
  end
  if love.keyboard.isDown('right') then
    self.mi_x = self.mi_x + 10
  end
  if love.keyboard.isDown('up') then
    self.mi_y = self.mi_y - 10
  end
  if love.keyboard.isDown('down') then
    self.mi_y = self.mi_y + 10
  end
  self.mi_x = self.mi_x/2
  self.mi_y = self.mi_y/2
end

function utils:draw_dev_hud() 
  love.graphics.setColor(1, 1, 0, 0.9)  
  love.graphics.rectangle('fill', 0, h - 16, w, 16)
  love.graphics.setColor(1, 1, 0, 0.8)  
  love.graphics.rectangle('fill', w - 30, h - 50, 10, 30)
  love.graphics.rectangle('fill', w - 40, h - 40, 30, 10)

  love.graphics.setColor(0.4, 0.4, 0, 1)  
  love.graphics.printf(
    "fps:"..love.timer.getFPS()..
    "/cx "..c_x.."/cy "..c_y..
    "/mx "..map_x.."/my "..map_y,
    16, h - 16, w-32, 'right')  
  love.graphics.rectangle("fill", self.mi_x + w - 30, self.mi_y + h - 40, 10, 10)
end