function game_over()
    sfx(7) -- death sfx
    player.is_dead = true

    if level > 0 then
        -- just deduct from previous level
        local last_lvl_score = lvl_scores[level]
        last_lvl_score.current = max(0, last_lvl_score.current - 3)
    end
end

framespassed = 120

function update_game_over()
    if (player.is_dead) then
        framespassed = 120 - game_over_frames
        if btnp(❎) then
            -- reset current level points
            lvl_scores[level + 1].current = 0
            open_game(level)
        end
        if btnp(🅾️) then
            open_menu()
        end

        return true
    end
    return false
end

function draw_game_over()
    if (game_over_frames > 0) then
        game_over_frames -= 1
        
        spr(6, player.x + (sin(t() * 2)) * 3, player.y - framespassed)
        
        return
    end

    rect(19, 31, 32 + 64 + 13, 32 + 61, 12)
    rectfill(20, 32, 32 + 64 + 12, 32 + 60, 7)
    outline_print_center("game over", 40, 7, 1, 2)
    if level > 0 then
        print_center("- 3 pts", 60)
    end
    print_center("press ❎ to try again", 80)
end