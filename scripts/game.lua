music(0)

map_pos=0
player_pos=60
gravity=1

-- function _init()
--   camera(0, 0)
-- end

local score = 0

function open_game() 
    score = 0
    act_update = update_game
    act_draw = draw_game
end

function update_game() 
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

function draw_game() 
    cls()
    map(0,0,map_pos,0,32,12)
    spr(2, 16, player_pos)
end