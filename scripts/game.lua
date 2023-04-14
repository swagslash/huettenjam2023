music(0)

player = {}
player.y = 60
player.x = 16
player.w = 8 -- width
player.h = 8 -- height
player.fall_direction = 1 -- 1 down, -1 up
player.can_toggle = false
player.last_time_grounded = 0

map_pos = 0
scroll_speed = 1

-- this is basically _init
function open_game()

    act_update = update_game
    act_draw = draw_game

    last_time_grounded = t() - 0.4
    camera(0, 0)

    snow = {}
    for x = 1, 60 do
        init_snowflake(x)
    end

    map_pos = 0
    player.y = 60
    player.fall_direction = 1
    player.can_toggle = true
    player.last_time_grounded = 0
end

function update_game()
    update_snow()
    -- scroll map to the left
    map_pos = map_pos - scroll_speed

    if btnp(❎) and player.can_toggle then
        toggle_gravity()
    end

    move_player()
end

function draw_game()
    -- clear screen
    cls()
    -- print fps
    print(stat(7))
    -- draw snow in background
    draw_snow()
    -- draw map
    map(0, 0, map_pos, 0, 32, 12)
    -- draw player sprite
    local is_facing_down = player.fall_direction < 0
    spr(2, player.x, player.y, 1, 1, false, is_facing_down)
end

function toggle_gravity()
    -- reverse gravity
    player.fall_direction = player.fall_direction * -1
    -- timestamp since last grounded
    player.last_time_grounded = t() - 0.4
    -- can toggle gravity
    player.can_toggle = false
end

function move_player()
    local time_falling = t() - player.last_time_grounded
    -- h = 1/2 * gravity * time^2
    local y_offset = 1 / 2 * 4 * time_falling * time_falling * player.fall_direction

    player.y = player.y + y_offset

    collides_y(y_offset)
end

function collides_y(offset_y)
    local p_x_left = player.x + scroll_speed
    local p_x_right = p_x_left + 8
    local p_y_top = player.y + offset_y
    local p_y_bottom = p_y_bottom
end