function setup_map() 
  -- setup internal map representation
  for y=0,map_h-1 do
    for x=0,map_w-1 do
      map[y * map_w + x] = 0
    end
  end
  
  for y=1,map_h-2 do
    for x=1,map_w-2 do
      map[y * map_w + x] = 1
    end
  end

  -- setup tiles
   for i=0, 63 do
      tile[i] = love.graphics.newImage(
        "tiles/separate/tile_"..string.format("%02d", i)..".png")
   end
end

function draw_map()
  love.graphics.setColor(1, 1, 1)
  
  for y = map_y, map_y + ht-1 do
    for x = map_x, map_x + wt-1 do  
      love.graphics.draw(
        tile[map[y * map_w + x]], 
        (math.floor(map_x_off) + (x - map_x) * tile_w), 
        (math.floor(map_y_off) + (y - map_y) * tile_h),
        0, tile_w/img_size, tile_h/img_size)
    end
  end
end

-- handle map cursor movement and map panning
-- basically, we move the cursor, until we get close to an edge - at which point we start 
-- panning the map instead. until we're running out of map, in which case we end with moving
-- the cursor right up the wall.
function map_handle_keypress(key)
  if(key == "right") then
    if(c_x >= wt - c_margin - 1) then 
      if(map_x < map_w - wt) then
        map_x = map_x + 1
        map_x_off = tile_w - 1
      else
        if(c_x < wt - 1) then
          c_x = c_x + 1
        end
      end
    else
      if(c_x < wt - 1) then
        c_x = c_x + 1
      end
    end
  end
  
  if(key == "left") then
    if(c_x <= c_margin) then
      if(map_x > 0) then
        map_x = map_x - 1
        map_x_off = -1 * tile_w + 1
      else
        if(c_x > 0) then
          c_x = c_x - 1
        end
      end
    else
      if(c_x > 0) then
        c_x = c_x - 1
      end
    end
  end

  if(key == "down") then
    if(c_y >= ht - c_margin - 1) then
      if(map_y < map_h - ht) then
        map_y = map_y + 1
        map_y_off = tile_h - 1
      else
        if(c_y < ht - 1) then
          c_y = c_y + 1
        end
      end
    else
      if(c_y < ht - 1) then
        c_y = c_y + 1
      end
    end
  end
  
  if(key == "up") then
    if(c_y <= c_margin) then
      if(map_y > 0) then
        map_y = map_y - 1
        map_y_off = -1 * tile_h + 1
      else
        if(c_y > 0) then
          c_y = c_y - 1
        end
      end
    else
      if(c_y > 0) then
        c_y = c_y - 1
      end
    end
  end
end

function map_handle_scroll_update() 
  if(map_x_off ~= 0) then map_x_off = map_x_off * map_smoothscroll_speed end
  if(map_x_off > -1 and map_x_off < 1) then map_x_off = 0 end
  if(map_y_off ~= 0) then map_y_off = map_y_off * map_smoothscroll_speed end
  if(map_y_off > -1 and map_y_off < 1) then map_y_off = 0 end
end