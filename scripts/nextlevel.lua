function next_level()
    player.is_finished = true
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
        outline_print_center("congratulations", 40, 7, 1, 2)
        print_center("score: "..score, 60)
        print_center("press ❎ to", 75)
        print_center("return to menu", 83)
    else
        outline_print_center("level finished", 40, 7, 1, 2)
        print_center("press ❎ to continue", 80)
    end
end