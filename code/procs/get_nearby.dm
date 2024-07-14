proc
	get_nearby(mob/Player/target, list/mobiles){
		for(var/mob/m in mobiles){
			if(m==target || m.loc==target.loc || !(target.insideBuilding == m.insideBuilding)){
				mobiles.Remove(m);
			}
		}

		return distance_order(target,mobiles);
	}

	/*get_nearby(mob/target, left, right, top, bottom){

		if(!isplayer(target) || target.blind){
			return FALSE;
		}

		var/list/mobiles = list()

		left = target.x-left
		right = target.x+right
		top = target.y+top
		bottom = target.y-bottom

		for(var/yy in top to bottom step -1){
			for(var/xx in left to right){
				var
					aY = Wrap(yy,target.loc.loc:y,target.loc.loc:getMaxY(),target.loc.loc:hideEdges)
					aX = Wrap(xx,target.loc.loc:x,target.loc.loc:getMaxX(),target.loc.loc:hideEdges)
					turf/T = locate(aX,aY,target.z)

				for(var/mob/m in T){
					if(m==target || m.loc==target.loc){ continue; }else{
						mobiles.Add(m);
					}
				}
			}
		}

		return mobiles;
	}*/