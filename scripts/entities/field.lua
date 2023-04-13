entities.field = entity:constructor({
  type = "field",
  x = 0,
  y = 0,
  layer = 64,
  width = 12,
  sprite = 50,

  -- hitbox = {
  --   x = 0,
  --   y = 0,
  --   width = 8,
  --   height = 8,
  -- },

  init = function(self)
    
  end,

  update = function(self)
    noop()
  end,

  draw = function(self)
    sspr((self.sprite % 16) * 8, (self.sprite \ 16) * 8, self.width, self.width, self.x, self.y, self.width, self.width)
    -- sspr((self.sprite % 16) * 8, (self.sprite \ 16) * 8, 16, 16, self.x, self.y + sin(t() * 2) * 2, 16, 16 - sin(t() * 2) * 2)
  end,

  -- draw = function(self)
  --   if self.kind == "goal" then
  --     -- line(self.x, self.y, self.x + self.width, self.y + self.width, 8)
  --     line(self.x + self.width, self.y, self.x, self.y + self.width, 12)
  --   end
  --   if self.kind == "obstacle" then
  --     line(self.x, self.y, self.x + self.width, self.y + self.width, 8)
  --     line(self.x + self.width, self.y, self.x, self.y + self.width, 8)
  --   end
  --   rect(self.x, self.y, self.x + self.width, self.y + self.width, 7)
  -- end,

  on_destroy = function(self)
    self.target:destroy()
  end
})