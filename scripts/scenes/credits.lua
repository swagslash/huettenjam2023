scenes.credits = object:new({
  init = function(self)
    noop()
  end,

  update = function(self)
    if btnp(5) then
      load_scene "title"
    end
  end,

  draw = function(self)
    local credits = {
      { "code sfx art", "w3d3", ""},
      -- { "original game", "@swagslash" },
      { "original game", "gustavat monomus", "cymbre w3d3" },
    }

    local offset = 0
    local origin = 48 - ((#credits - 1) * 24)

    for credit in all(credits) do
      print_centered(credit[1], origin + offset, 14)
      print_centered(credit[2], origin + offset + 8, 7)
      print_centered(credit[3], origin + offset + 16, 7)
      offset += 24
    end

    print_centered("return to title", 108, 7)
    spr(11, 24, 108)
    spr(11, 95, 108, 1, 1, true)
  end,
})