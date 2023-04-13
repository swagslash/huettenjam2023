entities.goal = entities.field:constructor({
  type = "goal",
  exclusive = true,
  sprite = 48,
  layer = 30,


  init = function(self)
    noop()
  end,

  -- draw = function(self)
  --   line(self.x + self.width, self.y, self.x, self.y + self.width, 12) 
  -- end,

  win = function(self)
    print("Won!")
  end,
})