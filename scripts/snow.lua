
function init_snowflake(x)
    drop={
        x = flr(rnd(128)),
        y = flr(rnd(110) - 5),
        gravity = (rnd(0.5) + 0.1),
        lr = -(rnd(0.15) + 0.3),
        size = flr(rnd(3) - 1)
    }

    snow[x]=drop
end

function update_snow()
    for x=1,#snow do
        local drop=snow[x]
       
        drop.y+=drop.gravity * fall_direction
        drop.x+=drop.lr

        drop.y = drop.y % 128
        drop.x = drop.x % 128
    end
end

function draw_snow()
    for x=1, #snow do
        local flake=snow[x]
        circfill(flake.x, flake.y, flake.size, 7)
    end
end