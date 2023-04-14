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

    if item_collision[1] == nil then
        return
    end

    c = item_collision[1]
    score = score + 1
    mset(c.x, c.y, 0)
end

function collides (positions, flags)
    local collisions = {}

    for c in all(positions) do
        -- map player coordinates to world/map coordinates (pixel --> sprite)
        local world_x = (c.x - map_scroll_x_offset) / 8
        local world_y = c.y / 8 + map_y_offset
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

function collides_with(collisions, flags)
    for c in all(collisions) do
        for f in all(flags) do
            if c.flag == f then
                return true
            end
        end
    end

    return false
end