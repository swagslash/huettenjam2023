act_update = nil
act_draw = nil
game_title = "swaglash_gravity_v0"

cartdata(game_title)

function _init() 
    open_menu()
end

function _update()
    act_update()
end

function _draw()
    cls()
    act_draw()
end
