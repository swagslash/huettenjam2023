music(0)

map_pos=0
player_pos=60
fall_direction=1 -- 1 down, 0 up
last_time_grounded=0 -- timestamp after player left the ground
is_facing_down=false

-- this is basically _init
function open_game() 
    act_update = update_game
    act_draw = draw_game

    last_time_grounded=t()-0.4
    camera(0, 0)
end

function update_game() 
    map_pos=map_pos-1
  
  if btnp(❎) then
    fall_direction=fall_direction*-1
    is_facing_down=fall_direction<0
    last_time_grounded=t()-0.4
  end
  
  time_falling=t()-last_time_grounded
  -- h = 1/2 * gravity * time^2
  offset = 1/2*7*time_falling*time_falling*fall_direction
  player_pos=player_pos+offset
end

function draw_game() 
    cls()
  map(0,0,map_pos,0,32,12)
  spr(2, 16, player_pos,1,1,false,is_facing_down)
end