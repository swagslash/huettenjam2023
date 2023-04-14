
local title_y = 32
local selections = {
    "play",
    "highscore",
}
local cur_sel = 1

function open_menu() 
    act_update = update_menu
    act_draw = draw_menu
end

function update_menu()
    if btnp(❎) then
        if cur_sel == 1 then
            open_game(1)
        end

        if cur_sel == 2 then
            //open_highscore()
        end
    end
    
    if btnp(⬆️) then
        cur_sel = wrap_int(cur_sel, 1, 2, 1)
        sfx(9)
    end
    if btnp(⬇️) then
        cur_sel = wrap_int(cur_sel, 1, 2, -1)
        sfx(9)
    end
end

function draw_menu()
    
    rect(0,0,127,127,7)

    -- TODO write cool sprites here instead of ugly text
    spr(192, 30, title_y - 20, 9, 5)
    -- outline_print(game_title, 64 - #game_title*4 / 2, title_y, 7, 5, 1)
    -- rectfill(32,title_y+10,98,title_y+10,7)
    -- rectfill(31,title_y+13,97,title_y+13,5)

    print_center("by swaglash", title_y+14, 5)
    print_center("by swagslash", title_y+13, 7) -- shadow

    rectfill(76, 119, 125, 125, 14)
    print("huettenjam23", 78, 120, 0)

    draw_selection();

    print("swagslash.io", 3, 120, 14)
end

function draw_selection() 
    for i=1, #selections do
        local pre = "   "
        local color = 1
        if cur_sel == i then 
            pre="❎ " 
            color = 12
        end
        print(pre..selections[i], 24, title_y+28+(i-1)*9, color)
    end
end