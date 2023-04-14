function next_level()
    player.is_finished = true

    local current_lvl_score = lvl_scores[level + 1]
    if current_lvl_score.current >= current_lvl_score.max then
        score += 10
    end
end

function update_level_finished()
    if player.is_finished then

        if btnp(❎) then
            if level >= final_level then
                open_menu()
            else
                open_game(level + 1)
            end
        end
        if btnp(🅾️) then
            open_menu()
        end

        return true
    end
    return false
end

function draw_level_finished()
    rect(19, 31, 32 + 64 + 13, 32 + 61, 12)
    rectfill(20, 32, 32 + 64 + 12, 32 + 60, 7)

    if level >= final_level then
        outline_print_center("congratulations", 40, 1, 10, 2)
        print_center("press ❎ to", 75)
        print_center("return to menu", 83)
    else
        outline_print_center("level finished", 40, 7, 1, 2)
        print_center("press ❎ to continue", 80)
    end

    -- always print scores
    local current_lvl_score = lvl_scores[level + 1]
    if current_lvl_score.current >= current_lvl_score.max then
        outline_print_center("FULL PIZZA BONUS", 56, 7, 8, 1)
        outline_print_center("+10", 64, 7, 8, 1)
    else
        print_center("collected "..current_lvl_score.current.." of "..current_lvl_score.max, 56)
        print_center("collectibles", 64)
    end
end