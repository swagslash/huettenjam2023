highscores={
	0,0,0,0,0,0,0,0,0,0
}

last_highscore = -1

function open_highscore()
    get_highscore()
    act_update = update_hs
    act_draw = draw_hs
end

function update_hs()
    if btnp(🅾️) or btnp(❎) then
        open_menu()
    end
end

function draw_hs()
    cls(1)
    rect(0,0,127,127,7)
    print("highscores:", 3, 3, 14)

    for i=1, #highscores do
        print(""..highscores[i], 4, 12 + (i-1)*7, 7);
    end

    print_center("back to menu 🅾️", 120, 12);
end

-- loads all hs from storage
function get_highscore()
	for i=1, #highscores do
		highscores[i]=dget(i)
	end
	last_highscore = dget(#highscores+1)
end

-- delete all hiscores
function delete_highscores()
	for i=1, #highscores do
		highscores[i]=0
		dset(i,0)
	end
end

-- save hs to storage
function save_highscore()
	for i=1, #highscores do
		dset(i,highscores[i])
	end
	dset(#highscores+1,last_highscore)
end

function add_highscore(score)
	last_highscore = score
	local placed = -1
	local notfound = true
	for i=1, #highscores do
		local current_score = highscores[i]
		if score > highscores[i] then
			highscores[i] = score
			score = current_score
			if notfound then
				placed = i
				notfound = false
			end
		end
	end
	save_highscore()
	return placed
end