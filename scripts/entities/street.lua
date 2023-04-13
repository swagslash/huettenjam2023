entities.street = entity:constructor({

  solid = false,
  layer = 10,
  x_offset = 4,
  tilesize = 12,
  width = 9,


  draw = function(self)
    log("rectfill")
    rectfill(self.x_offset + self.tilesize, 
    self.tilesize, 
    self.x_offset + self.tilesize * self.width - 1,
     self.tilesize * self.width - 1, 6)
    
    -- local x, y, offset = self.x, self.y, self.offset
    -- local overlay_y = self.direction == "down" and -4 or 4

    -- ovalfill(x, y - offset + 9, x + 127, y + 6 + offset, 0)
    -- transparent(function()
    --   for i = 0, 2 do
    --     oval(x, y + i - offset + 9, x + 127, y + 6 - i + offset, 7 - i)
    --   end
    -- end)

    -- rectfill(x, y + overlay_y, x + 127, y + 12 + overlay_y, 0)
  end
})