act_update = nil
act_draw = nil
game_title = "swaglash_gravity_v0"

cartdata(game_title)

function _init() 
    -- set black to not transparent
    -- and caucasian male skin tone to transparent
    palt(0, false)
    palt(15, true)

    open_menu()
end

function _update60()
    act_update()
end

function _draw()
    cls()
    act_draw()
end
