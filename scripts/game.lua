music(0)

player = {
    x = 16,
    y = 60,
    fall_direction = 1,  -- 1 down, -1 up
    can_toggle = false,
    last_time_grounded = 0
}

score = 0

player_sprite = 2 -- index of the player-sprite
solid_flag = 1 -- flag of solid blocks
deadly_flag = 2 -- flag of deadly blocks
item_flag = 3 -- flag of collectible items
all_flags = { solid_flag, deadly_flag }

map_x_offset = 0 -- x-offset of the map to draw
map_y_offset = 0 -- y-offset of the map to draw
map_scroll_speed = 1 -- speed of the world map scrolling
gravity = 4 -- gravity
initial_fall_speed = 0.4 -- initial velocity (time player is already falling)

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
    player.last_time_grounded = t() - initial_fall_speed

    score = 0
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
    local player_sprite = player.can_toggle and 3 or 4
    spr(player_sprite, player.x + global_draw_offset_x, player.y + global_draw_offset_y, 1, 1, false, is_facing_down)
    -- draw score
    print('score ' .. score, 0, 120, 12)
end

function game_over()
    open_game()
end

function toggle_gravity()
    -- reverse gravity
    player.fall_direction = player.fall_direction * -1
    -- timestamp since last grounded
    player.last_time_grounded = t() - initial_fall_speed
    -- can toggle gravity
    player.can_toggle = false
end

function move_player()
    local time_falling = t() - player.last_time_grounded
    -- h = 1/2 * gravity * time^2
    local y_offset = 1 / 2 * gravity * time_falling * time_falling * player.fall_direction

    local y_collision = collides_y(y_offset)
    if collides_with(y_collision, solid_flag) then
        player.can_toggle = true
        -- last time grounded set in toggle_gravity
    elseif collides_with(y_collision, deadly_flag) then
        game_over()
    else
        player.y = player.y + y_offset
    end

    collides_item()

    local x_collision = collides_x();
    if collides_with(x_collision, solid_flag) then
        game_over()
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

    return collides(positions, all_flags)
end

function collides_x()
    local p_x_right = player.x + map_scroll_speed + 7
    local p_y_top = player.y
    local p_y_bottom = p_y_top + 7

    local positions = {}
    add(positions, { x = p_x_right, y = p_y_top })
    add(positions, { x = p_x_right, y = p_y_bottom })

    return collides(positions, all_flags)
end


function collides_item ()
    local positions = {}
    add(positions, {x = player.x, y = player.y})
    add(positions, {x = player.x + 7, y = player.y})
    add(positions, {x = player.x, y = player.y + 7})
    add(positions, {x = player.x + 7, y = player.y + 7})

    -- check if already collided
    local item_collision = collides(positions, {item_flag})
    for c in all(item_collision) do
        score = score + 1
        mset(c.x, c.y, 0)
    end
end

function collides (positions, flags)
    local collisions = {}

    for c in all(positions) do
        -- map player coordinates to world/map coordinates (pixel --> sprite)
        local world_x = (c.x - map_x_offset) / 8
        local world_y = (c.y - map_y_offset) / 8
        -- get map tile
        local sprite = mget(world_x, world_y)
        -- check if sprite is solid

        for flag in all(flags) do
            if fget(sprite, flag) then
                add(collisions, {flag = flag, x = world_x, y = world_y })
            end
        end
    end

    return collisions
end

function collides_with(collisions, flag)
    for c in all(collisions) do
        if c.flag == flag then
            return true
        end
    end

    return false
end
