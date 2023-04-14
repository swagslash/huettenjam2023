music(0)

player = {
    x = 16,
    y = 60,
    fall_direction = 1,  -- 1 down, -1 up
    can_toggle = false,
    last_time_grounded = 0
}

player_sprite = 2 -- index of the player-sprite
solid_flag = 0 -- flag of solid blocks

map_x_offset = 0 -- x-offset of the map to draw
map_y_offset = 0 -- y-offset of the map to draw
map_scroll_speed = 0.1

map_level_height = 16 -- portion of the map to load

-- draw offsets for the player and map to position it in the middle of the screen
global_draw_offset_x = 0;
global_draw_offset_y = 0;

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
    map_x_offset = map_x_offset - map_scroll_speed

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
    map(0, 0, map_x_offset + global_draw_offset_x, map_y_offset + global_draw_offset_y, 128, map_level_height)
    -- draw player sprite
    local is_facing_down = player.fall_direction < 0
    spr(player_sprite, player.x + global_draw_offset_x, player.y + global_draw_offset_y, 1, 1, false, is_facing_down)
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
    local p_x_left = player.x + map_scroll_speed
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
    local p_x_right = player.x + map_scroll_speed + 7
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
        local world_x = (c.x - map_x_offset) / 8
        local world_y = (c.y - map_y_offset) / 8
        -- get map tile
        local sprite = mget(world_x, world_y)
        -- check if sprite is solid
        if (fget(sprite, solid_flag)) then
            return true
        end
    end

    return false
end