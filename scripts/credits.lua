
function open_credits()
    act_update = update_credits
    act_draw = draw_credits
end

function update_credits()
    if btnp(🅾️) or btnp(❎) then
        open_menu()
    end
end

function draw_credits()
    local spacing = 8
    cls(1)
    rect(0,0,127,127,7)
    print_center("- - - credits - - -", 3, 14)
    print_center("code", 13, 12)
    print_center("alex882 gustavat w3d3", 21, 7)
    print_center("art", 31, 12)
    print_center("gustavat sarah w3d3", 39, 7)
    print_center("sfx / music", 49, 12)
    print_center("xifiggam", 57,  7)
    print_center("levels", 67, 12)
    print_center("gustavat monomus", 75,  7)
    print_center("w3d3 xifiggam", 83,  7)

    print_center("thx for playing ♥", 98, 14)
    print_center("made for the huettenjam 2023", 106, 14)


    print_center("back to menu 🅾️", 120, 12);
end