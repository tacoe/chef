local Base = require "lib/knife/base"
require "utils"
require "map"

-- screen
w = 400
h = 240
  
-- state
menu = false

-- tile
tile = {}
tile_w = 24 -- tile size, in pixels
tile_h = 24
wt = math.floor(w / tile_w) -- width of the viewport in tiles
ht = math.floor(h / tile_h)
img_size = 16

-- map
map = {}
map_w = 20 -- map size, in tiles)
map_h = 20
map_x = 0 -- view offset into map, in tiles
map_y = 0
map_x_off = 0 -- additional display offset for smooth scroll, in pixels. may be fractional: truncate to draw
map_y_off = 0
map_smoothscroll_speed = 0.7

-- cursor
c_x = 5 -- cursor position on the map, in (virtual) tiles
c_y = 5
c_margin = 3 -- try to keep this margin from cursor to side of window

function love.load()
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  love.window.setMode(w, h)
  love.keyboard.setKeyRepeat(true)
  love.graphics.setDefaultFilter('nearest', 'nearest', 1)
  love.graphics.setBackgroundColor(1,1,1)
  love.graphics.setNewFont("fonts/m5x7.ttf", 16)
 
  setup_map()
  
  start_time = love.timer.getTime()
end

function love.update(dt)
  utils:update_dev_hud()
  map_handle_scroll_update()
end

function love.keypressed(key, code, rep)
  if menu then
    -- handle menu UI here
  else
    map_handle_keypress(key)
  end
  
  -- A 
  if(key == "return") then
    menu = not menu
  end
  
  -- B 
  if(key == "space") then
  end

end

function love.draw()
  -- the map itself
  draw_map()
  
  -- cursor
  love.graphics.setColor(0, 0, 0, (3 + math.sin(4 * love.timer.getTime() - start_time)) / 4)

  love.graphics.rectangle('line', c_x * tile_w, c_y * tile_h, tile_w, tile_h)
  love.graphics.rectangle('line', c_x * tile_w - 2, c_y * tile_h - 2, tile_w + 4, tile_h + 4)
  love.graphics.rectangle('line', c_x * tile_w - 4, c_y * tile_h - 4, tile_w + 8, tile_h + 8)
  
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
