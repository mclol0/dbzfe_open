proc
	get_general_dir(atom/ref,atom/target)
		if(target.z > ref.z) return UP
		if(target.z < ref.z) return DOWN

		var/d = get_dir(ref,target)
		if(d&d-1)        // diagonal
			var/ax = abs(ref.getX() - target.getX())
			var/ay = abs(ref.getY() - target.getY())
			if(ax >= (ay << 1))      return d & (EAST|WEST)   // keep east/west (4 and 8)
			else if(ay >= (ax << 1)) return d & (NORTH|SOUTH) // keep north/south (1 and 2)
		return d

	a_get_dir(atom/A=src, atom/B){
		var
			planet/Area = A.getArea()
			dir = NULL;
			horizontal = 0
			vertical = 0

		if(Area.hideEdges){
			return get_dir(A,B);
		}

		if(isturf(A) || isturf(B)){
			dir = get_dir(A,B);
		}else{
			dir = get_general_dir(A,B)
		}

		if(dir & NORTH){
			if(abs(A.getY()-B.getY()) > Area.getDY()*0.5){
				vertical = 2
			}
			else{
				vertical = 1
			}
		}
		else if(dir & SOUTH){
			if(abs(A.getY()-B.getY()) < Area.getDY()*0.5){
				vertical = 2
			}
			else{
				vertical = 1
			}
		}
		if(dir & EAST){
			if(abs(A.getX()-B.getX()) > Area.getDX()*0.5){
				horizontal = 8
			}
			else{
				horizontal = 4
			}
		}
		else if(dir & WEST){
			if(abs(A.getX()-B.getX()) < Area.getDX()*0.5){
				horizontal = 8
			}
			else{
				horizontal = 4
			}
		}
		return horizontal | vertical
	}