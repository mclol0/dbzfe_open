proc
	a_oview_melee(distance, atom/center=src)
		if(!center || !center.loc || !center.loc.loc) return;

		var/list/atoms = list()
		var/top = center.y+distance
		var/bottom = center.y-distance
		var/left = center.x-distance
		var/right = center.x+distance
		for(var/yy = top, yy >= bottom, yy--)
			for(var/xx = left, xx <= right, xx++)
				if(!center) { return; }

				var
					aY = Wrap(yy,center.loc.loc:y,center.loc.loc:getMaxY(),center.loc.loc:hideEdges)
					aX = Wrap(xx,center.loc.loc:x,center.loc.loc:getMaxX(),center.loc.loc:hideEdges)
				for(var/atom/A in locate(aX,aY,center.z))
					if(A == center || !A.visible || A.invisible){continue}
					atoms.Add(A)

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return distance_order(center,atoms)

	a_oview(distance, atom/center=src)
		if(!center || !center.loc || !center.loc.loc) return;

		var/list/atoms = list()
		var/top = center.y+distance
		var/bottom = center.y-distance
		var/left = center.x-distance
		var/right = center.x+distance
		for(var/yy = top, yy >= bottom, yy--)
			for(var/xx = left, xx <= right, xx++)
				if(!center) { return; }

				var
					aY = Wrap(yy,center.loc.loc:y,center.loc.loc:getMaxY(),center.loc.loc:hideEdges)
					aX = Wrap(xx,center.loc.loc:x,center.loc.loc:getMaxX(),center.loc.loc:hideEdges)
				for(var/atom/A in locate(aX,aY,center.z))
					if(A == center || A.loc == center.loc || !A.visible || A.invisible){continue}
					atoms.Add(A)

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return distance_order(center,atoms)

	t_oview(distance, atom/center=src)
		if(!center || !center.loc || !center.loc.loc) return;

		var/list/atoms = list()
		var/top = center.y+distance
		var/bottom = center.y-distance
		var/left = center.x-distance
		var/right = center.x+distance
		for(var/yy = top, yy >= bottom, yy--)
			for(var/xx = left, xx <= right, xx++)
				if(!center) { return; }

				var
					aY = Wrap(yy,center.loc.loc:y,center.loc.loc:getMaxY(),center.loc.loc:hideEdges)
					aX = Wrap(xx,center.loc.loc:x,center.loc.loc:getMaxX(),center.loc.loc:hideEdges)
					turf/T = locate(aX,aY,center.z)

				atoms.Add(T);

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return atoms

	oview_outer(distance, atom/center)
	{
		if(!center || !center.loc || !center.loc.loc) return;

		var/list/atoms = list()
		var/top = center.y+distance
		var/bottom = center.y-distance
		var/left = center.x-distance
		var/right = center.x+distance
		for(var/yy = top, yy >= bottom, yy--){
			for(var/xx = left, xx <= right, xx++){
				if(!center) { return; }
				var
					aY = Wrap(yy,center.loc.loc:y,center.loc.loc:getMaxY(),center.loc.loc:hideEdges)
					aX = Wrap(xx,center.loc.loc:x,center.loc.loc:getMaxX(),center.loc.loc:hideEdges)
				for(var/atom/A in locate(aX,aY,center.z)){
					if(A == center || A.loc == center.loc || !A.visible || A.invisible){continue}
					atoms.Add(A)
				}
			}
		}

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return atoms
	}

	ov_out(min_distance, max_distance, atom/center){
		if(!center) return;

		var/atoms[] = list();

		for(var/mob/Player/m in game.players){
			if(center && m && center.getArea() == m.getArea()){
				if(a_get_dist(center,m) >= min_distance && a_get_dist(center,m) <= max_distance){
					atoms.Add(m);
				}
			}
		}

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return atoms;
	}

	radius_out(min_distance, max_distance, atom/center){
		if(!center) return;

		var/atoms[] = list();

		for(var/mob/m in center.getArea()){
			if(center && m){
				if(a_get_dist(center,m) >= min_distance && a_get_dist(center,m) <= max_distance){
					atoms.Add(m);
				}
			}
		}

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return atoms;
	}

	a_oview_extra(distance, atom/center, atom/center2)
	{
		if(!center || !center.loc || !center.loc.loc || !center2 || !center2.loc || !center2.loc.loc) return;

		var/list/atoms = list()
		var/top = center.y+distance
		var/bottom = center.y-distance
		var/left = center.x-distance
		var/right = center.x+distance
		for(var/yy = top, yy >= bottom, yy--){
			for(var/xx = left, xx <= right, xx++){
				if(!center) { return; }

				var
					aY = Wrap(yy,center.loc.loc:y,center.loc.loc:getMaxY(),center.loc.loc:hideEdges)
					aX = Wrap(xx,center.loc.loc:x,center.loc.loc:getMaxX(),center.loc.loc:hideEdges)
				for(var/atom/A in locate(aX,aY,center.z)){
					if(A == center || A == center2 || !A.visible || A.invisible){continue}
					atoms.Add(A)
				}
			}
		}

		if(istype(center,/mob) && center:insideBuilding){
			for(var/mob/m in atoms){
				if((center:insideBuilding != m:insideBuilding)){
					atoms.Remove(m)
				}
			}
		}

		return atoms
	}