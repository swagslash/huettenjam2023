function print_center(str, y, col)
    print(str, 64 - #str*4 / 2, y, col)
end

function outline_print(str, x, y, col, out_col, weight)
    if not weight then weight = 1 end 
    for _x=-weight, weight do
        for _y=-weight, weight do
            print(str, x+_x, y+_y, out_col)
        end        
    end
    print(str, x, y, col)      
end

function outline_print_center(str, y, col, out_col, weight)
    x = 64 - #str*4 / 2
    if not weight then weight = 1 end 
    for _x=-weight, weight do
        for _y=-weight, weight do
            print(str, x+_x, y+_y, out_col)
        end        
    end
    print(str, x, y, col)      
end

function wrap_int(int, min_i, max_i, add_i)
	if not add_i then add_i = 0 end
	local new_i = int+add_i
	if new_i < min_i then return max_i end  
	if new_i > max_i then return min_i end
	return new_i
end