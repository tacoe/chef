local Base = require "lib/knife/base"
require "utils"

-- screen
w = 400
h = 240

  
-- state
menu = false


function setupcards()
  cols = { "clubs", "diamonds", "hearts", "spades" }
  vals = { "A", "02", "03", "04", "05", "06", "07", "08", "09", "10", "J", "Q", "K" }

  card_imgs = {}
  for i, col in ipairs(cols) do
    card_imgs[i] = {}
    for j, val in ipairs(vals) do
      fn = "images/card_"..cols[i].."_"..vals[j]..".png"
      print(fn)
      card_imgs[i][j] = love.graphics.newImage(fn)
    end
  end
end

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  love.window.setMode(w, h)
  love.keyboard.setKeyRepeat(true)
  love.graphics.setDefaultFilter('nearest', 'nearest', 1)
  love.graphics.setBackgroundColor(1,1,1)
  love.graphics.setNewFont("fonts/m5x7.ttf", 16)
  
  setupcards()
end

function love.update(dt)
  utils:update_dev_hud()
end

function love.keypressed(key, code, rep)
  if menu then
    -- handle menu UI here
    return
  end
  
  if(key == "return") then
    menu = not menu
  end
end

function love.draw()
  -- cards
  love.graphics.setColor(1, 1, 1)
  
  for i, col in ipairs(cols) do
    for j, val in ipairs(vals) do
      love.graphics.draw(card_imgs[i][j], i * 50, j * 10 * (1 + math.sin(love.timer.getTime())))
    end
  end
  
  -- cursor
  
  -- menu
  if menu then
    mex = w/2 - 100
    mey = h/2 - 60
    mew = 200
    meh = 120
    
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', mex+10, mey+10, mew, meh)
    love.graphics.rectangle('fill', mex, mey, mew, meh)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', mex+2, mey+2, mew-4, meh-4)    
  end
    
  -- debug info
  utils:draw_dev_hud()
end
