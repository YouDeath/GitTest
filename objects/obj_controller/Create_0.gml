function draw_map(size_x, size_y){
	for (var i = 0; i < size_x; i++){
		for (var j = 0; j < size_x; j++){
			draw_sprite(spr_cell, 0, i*cell_size, j*cell_size)	
		}
	}
}

function create_map(size_x, size_y, head_pos_x, , head_pos_y){
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

function snake_move(head_pos_x, head_pos_y, snake_len, move_dir){
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
	if global.map[head_pos_x+move_rel_x, head_pos_y+move_rel_y] == -1{
		snake_len+=1
	}
	var now_x = head_pos_x+move_rel_x
	var now_y = head_pos_y+move_rel_y
	for (var i = 0; i < snake_len; i++){
		global.map[now_x, now_y] = i
		var next_x = 0
		var next_y = 0
		if global.map[now_x+1, now_y] == i{
			next_x = now_x+1
			next_y = now_y
		}
		if global.map[now_x, now_y-1] == i{
			next_x = now_x
			next_y = now_y-1
		}
		if global.map[now_x-1, now_y] == i{
			next_x = now_x-1
			next_y = now_y
		}
		if global.map[now_x, now_y+1] == i{
			next_x = now_x
			next_y = now_y+1
		}
		now_x = next_y
		now_y = next_y
	}
}

head_pos_x = 3
snake_len = 2
head_pos_y = (size_y-1)/2
cell_size = 32
map_size_x = 15
map_size_y = 15
move_dir = 0
global.map = create_map(map_size_x, map_size_y, head_pos_x, head_pos_y)


