scenes.level = object:new({
  offset = 4,
  tilesize = 12,
  width = 8,
  layer = 1,

  init = function(self)
    level = self

    --space.particles = false
    -- space:animate({ speed = 1 }, 30, easeoutquad)

    tiles = {}
    level_complete = false

    local current_level = levels[world]
    local goalX, goalY = unpack(split(current_level[1]))
    local obstacleCoords = split(current_level[2])

    self.street = entities.street:new({})
    -- rectfill(self.offset + self.tilesize, self.tilesize, 
    -- self.offset + self.tilesize * self.width, self.tilesize * self.width, 6)
    
    for i = 1, 8 do
      for j = 1, 8 do
        local isGoal = goalX == i and goalY == j
        if isGoal then
          add(tiles, entities.goal:new({ 
            x = self.offset + i * self.tilesize, 
            y = j * self.tilesize
          }))
        else
          add(tiles, entities.field:new({ 
            x = self.offset + i * self.tilesize, 
            y = j * self.tilesize, 
            kind = isGoal and "goal" or "empty" }
          ))
        end
      end
    end
    -- bottom_gate:animate({ y = 120 }, 30, easeoutquad)
    -- wait(10, function() bottom_gate:close() end)

    -- gate = entities.gate:new({ y = -32, is_open = true })
    -- gate:animate({ y = -8 }, 30, easeoutquad)
    -- wait(12, function() gate:close() end)

    -- gate.portal.on_hit = function(self, other)
    --   if other == player
    --   and player.projectile
    --   and level_complete then
    --     level_id += 1
    --     load_scene "transition"
    --     gate.portal.on_hit = noop
    --   end
    -- end

    local world = 1
    -- if (player.projectile.charged) world = 2
    -- if (player.projectile.eggplant) world = 3
    -- local current_level = levels[world][level_id]
    -- local pool = split(current_level)
    -- local positions = {
    --   {18,16}, {32,16}, {56,16}, {80,16}, {104,16},
    --   {18,40}, {32,40}, {56,40}, {80,40}, {104,40},
    -- }

    -- for i = 1, 3 do
    --   local enemy_type = rnd(pool)
    --   local position = rnd(positions)
    --   del(positions, position)

    --   if (entities[enemy_type].exclusive) del(pool, enemy_type)

      -- add(enemies, entities[enemy_type]:new({
      --   x = position[1],
      --   y = position[2],
      --   on_destroy = function(self)
      --     del(enemies, self)
      --   end
      -- }))
    -- end

    -- player:animate({ x = 52, y = 88 }, 30, easeoutquad, function()
    --   player:enable()
    -- end)

    -- for e in all(enemies) do
    --   local tx, ty = e.x, e.y
    --   e.x = 52
    --   e.y = -48
    --   e:animate({ x = tx, y = ty }, 30, easeoutquad)
    -- end
  end,

  draw = function(self)
    -- rectfill(self.offset + self.tilesize, self.tilesize, 
    -- self.offset + (self.tilesize + 1) * self.width, (self.tilesize + 1) * self.width, 6)
    
    -- if #enemies == 0 and not level_complete then
    --   gate:open()
    --   level_complete = true
    -- end

    -- if player.health <= 0 then
    --   load_scene "gameover"
    -- end
  end
})