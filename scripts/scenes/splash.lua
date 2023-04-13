scenes.splash = object:new({
  init = function(self)
    wait(240, function()
      load_scene "title"
    end)

    -- music(0, 2000)
  end,

  update = function(self)
    if (btnp(5)) then
      load_scene "title"
    end
  end,

  draw = function(self)
    -- line(50, 64, 77, 64, 2)
    -- line(51, 65, 76, 65)

    -- for i = 0, 5 do
    --   local j = i * 2
    --   line(52 + j, 66 + i, 75 - j, 66 + i, 2)
    --   rectfill(52 + j, 46 - i, 75 - j, 65 + i, 8)
    -- end

    -- rect(51, 47, 76, 64, 8)
    -- rectfill(50, 48, 77, 63)
    -- rectfill(56, 51, 60, 60, 7)

    -- for i = 0, 4 do
    --   line(63 + i, 55 - i, 68 + i, 55 - i)
    --   line(63 + i, 56 + i, 68 + i, 56 + i)
    -- end
    
    sspr(112, 96, 16, 16, 48, 40, 32, 32)
    -- spr(206, 38, 20, 6, 2)
    -- spr(192, 38, 20, 6, 2)
    -- spr(224, 7, 40, 16, 2)

    ? "swagslash", 48, 80, 7
    ? "studios", 51, 87, 7
    ? "presents", 51, 100, 6
  end
})