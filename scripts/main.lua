music(0)

map_pos=0
player_pos=60
gravity=1

function _init()
  camera(0, 0)
end

function _update()
  map_pos=map_pos-1
  
  if gravity<0 then
    player_pos=player_pos-1
  else
    player_pos=player_pos+1
  end
  
  if btnp(❎) then
    gravity=gravity*-1
  end
end

function _draw()
  cls()
  map(0,0,map_pos,0,32,12)
  spr(2, 16, player_pos)

end