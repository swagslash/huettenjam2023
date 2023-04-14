function game_over()
    sfx(7) -- death sfx
    player.is_dead = true
end

framespassed = 120

function update_game_over()
    if (player.is_dead) then
        framespassed = 120 - game_over_frames
        if btnp(❎) then
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
    print_center("score: "..score, 60)
    print_center("press ❎ to try again", 80)
end