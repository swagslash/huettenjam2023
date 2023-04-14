local sprite_width = 72
local sprite_height = 32
local bounce_multiplier = 5
local logo_y = 38
local title_y = 55
local selections = {
    "play",
    "highscore",
}
local cur_sel = 1

function open_menu()
    score = 0
    act_update = update_menu
    act_draw = draw_menu
    music(-1, 300)
    music(6)

    for x = 1, 60 do
        init_snowflake(x)
    end
end

function update_menu()
    update_snow()

    if btnp(❎) then
        if cur_sel == 1 then
            open_game(0)
        end

        if cur_sel == 2 then
            open_highscore()
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
    cls(1)
    rect(0,0,127,127,7)

    draw_snow()

    local s_w = 8 + sprite_width + sin(t() * 0.55) * bounce_multiplier
    local s_h = 8 + sprite_height + sin(t() * 0.55) * bounce_multiplier

    local draw_x = 64 - s_w / 2
    local draw_y = logo_y - s_h / 2

    sspr(0, 96, 72, 32, draw_x, draw_y, s_w, s_h)

    print_center("by swagslash", title_y+14, 5)
    print_center("by swagslash", title_y+13, 7) -- shadow

    rectfill(76, 119, 125, 125, 14)
    print("huettenjam23", 78, 120, 0)

    draw_selection();

    print("swagslash.io", 3, 120, 14)
end

function draw_selection() 
    for i=1, #selections do
        local pre = "   "
        local color = 13
        if cur_sel == i then 
            pre="❎ " 
            color = 12
        end
        print(pre..selections[i], 24, title_y+28+(i-1)*9, color)
    end
end