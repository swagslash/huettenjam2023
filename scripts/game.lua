music(2)

player_start_x = 16
player_start_y = 64
player = {
    x = player_start_x,
    y = player_start_y,
    fall_direction = 1,  -- 1 down, -1 up
    can_toggle = false,
    last_time_grounded = 0,
    is_dead = false,
    is_finished = false
}

score = 0

player_sprite = 2 -- index of the player-sprite
solid_flag = 1 -- flag of solid blocks
deadly_flag = 2 -- flag of deadly blocks
item_flag = 3 -- flag of collectible items
all_flags = { solid_flag, deadly_flag }

map_level_height = 16 -- portion of the map to load
map_y_offset = 0 -- y-offset of the level | 1 level = 16 blocks
map_scroll_x_offset = 0 -- x-offset of the map to draw
map_scroll_speed = 1 -- speed of the world map scrolling
gravity = 4 -- gravity
initial_fall_speed = 0.4 -- initial velocity (time player is already falling)

-- draw offsets for the player and map to position it in the middle of the screen
global_draw_offset_x = 0
global_draw_offset_y = 0
game_over_frames = 120

level_finished_offset = 100 -- block offset when the level finishes
level = 0
final_level = 1

-- this is basically _init
function open_game(next_level)
    act_update = update_game
    act_draw = draw_game

    camera(0, 0)
    snow = {}
    for x = 1, 60 do
        init_snowflake(x)
    end

    player.x = player_start_x
    player.y = player_start_y
    player.fall_direction = 1
    player.can_toggle = false
    player.last_time_grounded = t() - initial_fall_speed
    player.is_dead = false
    player.is_finished = false

    map_scroll_x_offset = 0
    map_y_offset = level * map_level_height

    if next_level == level then
        score = 0
    end

    level = next_level

    map_scroll_x_offset = 0
    map_y_offset = 16 * level
end

function update_game()
    update_snow()

    if update_game_over() then
        return
    end

    if update_level_finished() then
        return
    end

    if has_finished() then
        next_level()
        return
    end

    -- scroll map to the left
    map_scroll_x_offset = map_scroll_x_offset - map_scroll_speed

    if btnp(❎) and player.can_toggle then
        toggle_gravity()
    end

    move_player()
end

function draw_game()
    -- clear screen
    cls(1)
    -- print fps
    print(stat(7))

    -- draw snow in background
    draw_snow()
    -- draw map
    map(0, map_y_offset, map_scroll_x_offset + global_draw_offset_x, global_draw_offset_y, 128, map_level_height)
    -- draw player sprite
    local is_facing_down = player.fall_direction < 0
    local player_sprite = player.can_toggle and 3 or 4
    player_sprite = not player.is_dead and player_sprite or 5
    spr(player_sprite, player.x + global_draw_offset_x, player.y + global_draw_offset_y, 1, 1, false, is_facing_down)

    -- draw game over screen on top if dead
    if player.is_dead then
        draw_game_over()
    elseif player.is_finished then
        draw_level_finished()
    else
        -- draw score
        print('score ' .. score, 0, 120, 12)
        print('level ' .. level + 1, 100, 120, 12)
    end
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
        player.last_time_grounded = t() - initial_fall_speed
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

function has_finished()
    local map_tiles_passed = map_scroll_x_offset / 8
    return (map_tiles_passed * -1) > level_finished_offset
end
