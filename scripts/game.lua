music(0)

player = {}
player.y = 60
player.x = 16
player.w = 8 -- width
player.h = 8 -- height
player.fall_direction = 1 -- 1 down, -1 up
player.can_toggle = false
player.last_time_grounded = 0

map_x_offset = 0
scroll_speed = 0.1

-- this is basically _init
function open_game()
    act_update = update_game
    act_draw = draw_game

    camera(0, 0)

    snow = {}
    for x = 1, 60 do
        init_snowflake(x)
    end

    map_x_offset = 0
    player.y = 60
    player.fall_direction = 1
    player.can_toggle = true
    player.last_time_grounded = t()
end

function update_game()
    update_snow()
    -- scroll map to the left
    map_x_offset = map_x_offset - scroll_speed

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
    map(0, 0, map_x_offset, 0, 32, 12)
    -- draw player sprite
    local is_facing_down = player.fall_direction < 0
    spr(2, player.x, player.y, 1, 1, false, is_facing_down)
end

function game_over()

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
    local y_offset = 1 / 2 * 2 * time_falling * time_falling * player.fall_direction



    if collides_y(y_offset) then
        player.can_toggle = true
        player.last_time_grounded = t()
    else
        player.y = player.y + y_offset
    end

    if (collides_x()) then
        open_game()
    end
end

function collides_y(offset_y)
    local p_x_left = player.x + scroll_speed
    local p_x_right = p_x_left + 7
    local p_y_top = player.y + offset_y
    local p_y_bottom = p_y_top + 7

    local positions = {}
    add(positions, { x = p_x_left, y = p_y_top })
    add(positions, { x = p_x_right, y = p_y_top })
    add(positions, { x = p_x_left, y = p_y_bottom })
    add(positions, { x = p_x_right, y = p_y_bottom })

    return collides(positions)
end

function collides_x()
    local p_x_right = player.x + scroll_speed + 7
    local p_y_top = player.y
    local p_y_bottom = p_y_top + 7

    local positions = {}
    add(positions, { x = p_x_right, y = p_y_top })
    add(positions, { x = p_x_right, y = p_y_bottom })

    return collides(positions)
end

function collides (positions)
    for c in all(positions) do
        -- map player coordinates to world/map coordinates (pixel --> sprite)
        local world_x = (c.x - map_x_offset) / 8;
        local world_y = c.y / 8;
        -- get map tile
        local sprite = mget(world_x, world_y)
        -- check if sprite is solid
        if (fget(sprite, 0)) then
            return true
        end
    end

    return false
end