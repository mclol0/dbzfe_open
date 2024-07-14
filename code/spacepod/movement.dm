obj/spacepod/Move(new_loc, new_dir, step_x=0, step_y=0){
	var nx = x
	var ny = y

	if(new_dir & EAST){
		nx ++
	}
	else if(new_dir & WEST){
		nx --
	}
	if(new_dir & NORTH){
		ny ++
	}
	else if(new_dir & SOUTH){
		ny --
	}

	if(isplanet(loc.loc)){
		if(nx > loc.loc:getMaxX()){
			nx = (loc.loc:x + x - loc.loc:getMaxX())
		}
		else if(nx < loc.loc:x){
			nx = (loc.loc:x - x + loc.loc:getMaxX())
		}
		if(ny > loc.loc:getMaxY()){
			ny = (loc.loc:y + y - loc.loc:getMaxY())
		}
		else if(ny < loc.loc:y){
			ny = (loc.loc:y - y + loc.loc:getMaxY())
		}
	}else{
		if(nx > world.maxx){
			nx -= world.maxx
		}
		else if(nx < 1){
			nx += world.maxx
		}
		if(ny > world.maxy){
			ny -= world.maxy
		}
		else if(ny < 1){
			ny += world.maxy
		}
	}

	..(locate(nx, ny, z), new_dir)
}