entities.star = entity:constructor({
  layer = -1,
  persist = true,
  color = 7,

  init = function(self)
    self.x = -20 --flr(rnd(127) - 20)
    self.y = flr(rnd(128))
    self.speed = rnd(6)
  end,

  update = function(self)
    if current_scene == scenes.level then
      self:destroy()
    end

    local mx = player and (player.vx  * .05) or 0
    local my = player and (player.vy * -.1) or 0

    -- self.y -= mx * self.speed
    self.x -= (self.speed * space.speed) + (mx * self.speed)

    if self.x > 128 + 20 or self.x < -20 then
      -- self.y = flr(rnd(127))
      self.x = 148
    end
  end,

  draw = function(self)
    line(
      self.x,
      self.y,
      self.x + flr(self.speed * 1),
      self.y, -- flr(self.speed * space.speed / 2),
      self.color
    )
    line(
      self.x + flr(self.speed * 1),
      self.y,
      self.x + flr(self.speed * 5),
      self.y, -- flr(self.speed * space.speed / 2),
      self.color - 1
    )
    line(
      self.x + flr(self.speed * 5),
      self.y,
      self.x + flr(self.speed * 6),
      self.y,
      self.color - 2
    )
  end
})