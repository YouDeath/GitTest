function draw_map(size_x, size_y){
	for (var i = 0; i < size_x; i++){
		for (var j = 0; j < size_x; j++){
			draw_sprite(spr_cell, 0, i*cell_size, j*cell_size)	
		}
	}
}

function create_map(size_x, size_y, head_pos_x, head_pos_y){
	var map
	for (var i = 0; i < size_x; i++){
		for (var j = 0; j < size_y; j++){
			map[i][j] = -100
		}
	}
	map[head_pos_x][head_pos_y] = 0
	map[head_pos_x-1][head_pos_y] = 1
	return map
}

function snake_move(move_dir){
	var move_rel_x
	var move_rel_y
	switch move_dir{
		case 0:{
			move_rel_x = 1
			move_rel_y = 0
			break;
		}
		case 90:{
			move_rel_x = 0
			move_rel_y = -1
			break;
		}
		case 180:{
			move_rel_x = -1
			move_rel_y = 0
			break;
		}
		case 270:{
			move_rel_x = 0
			move_rel_y = 1
			break;
		}
	}
	if in_range(map_size_x, map_size_y, head_pos_x+move_rel_x, head_pos_y+move_rel_y){
		if global.map[head_pos_x+move_rel_x, head_pos_y+move_rel_y] >= 0{
			return 0
		}
	}
	else{
		return 0
	}
	if global.map[head_pos_x+move_rel_x, head_pos_y+move_rel_y] == -1{
		snake_len+=1
		create_item()
	}
	var now_x = head_pos_x+move_rel_x
	var now_y = head_pos_y+move_rel_y
	head_pos_x +=move_rel_x
	head_pos_y +=move_rel_y
	for (var i = 0; i < snake_len; i++){
		global.map[now_x, now_y] = i
		var next_x = -1
		var next_y = -1
		show_debug_message(now_x)
		show_debug_message(now_y)
		if in_range(map_size_x, map_size_y, now_x+1, now_y){
			if global.map[now_x+1, now_y] == i{
				next_x = now_x+1
				next_y = now_y
			}
		}
		if in_range(map_size_x, map_size_y,now_x, now_y-1){
			if global.map[now_x, now_y-1] == i{
				next_x = now_x
				next_y = now_y-1
			}
		}
		if in_range(map_size_x, map_size_y, now_x-1, now_y){
			if global.map[now_x-1, now_y] == i{
				next_x = now_x-1
				next_y = now_y
			}
		}
		if in_range(map_size_x, map_size_y, now_x, now_y+1){
			if global.map[now_x, now_y+1] == i{
				next_x = now_x
				next_y = now_y+1
			}
		}
		now_x = next_x
		now_y = next_y
	}
	if now_x != -1 and now_y != -1{
		global.map[now_x, now_y] = -100
	}
	return 1
}

function draw_snake_controller(head_pos_x, head_pos_y){
	var now_x = head_pos_x
	var now_y = head_pos_y
	for (var i = 0; i < snake_len; i++){
		draw_sprite(spr_snake, 0, now_x*cell_size, now_y*cell_size)
		var next_x = -1
		var next_y = -1
		if in_range(map_size_x, map_size_y, now_x+1, now_y){
			if global.map[now_x+1, now_y] == i+1{
				next_x = now_x+1
				next_y = now_y
			}
		}
		if in_range(map_size_x, map_size_y,now_x, now_y-1){
			if global.map[now_x, now_y-1] == i+1{
				next_x = now_x
				next_y = now_y-1
			}
		}
		if in_range(map_size_x, map_size_y, now_x-1, now_y){
			if global.map[now_x-1, now_y] == i+1{
				next_x = now_x-1
				next_y = now_y
			}
		}
		if in_range(map_size_x, map_size_y, now_x, now_y+1){
			if global.map[now_x, now_y+1] == i+1{
				next_x = now_x
				next_y = now_y+1
			}
		}
		now_x = next_x
		now_y = next_y
	}
}

function create_item(){
	need_generate = true
	while need_generate{
		var item_x = irandom_range(0, map_size_x-1)
		var item_y = irandom_range(0, map_size_y-1)
		if global.map[item_x,item_y] < -1{
			need_generate = false
			global.map[item_x,item_y] = -1
		}
	}
}

function draw_item(){
	for (var i = 0; i < map_size_x; i++){
		for (var j = 0; j < map_size_y; j++){
			if global.map[i][j] == -1{
				draw_sprite(spr_item, 0, i*cell_size, j*cell_size)
			}
		}
	}
}

function in_range(max_x,max_y,test_x,test_y){
	return  (max_x > test_x and max_y > test_y and test_x >= 0 and test_y >= 0)
}

step = 0
snake_len = 2
cell_size = 32
map_size_x = 15
map_size_y = 15
move_dir = 0
head_pos_x = 3
head_pos_y = (map_size_y-1)/2
global.map = create_map(map_size_x, map_size_y, head_pos_x, head_pos_y)
create_item()


