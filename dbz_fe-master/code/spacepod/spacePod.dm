mob/proc/checkPod(){
	if(src:spacePod && (src in src:spacePod:passengers)){
		return TRUE;
	}
	return FALSE;
}

obj
	spacepod
		var/SHOW_IN_MAP = TRUE;

		var
			tmp
				DISPLAY=NULL;
				ref
				transit=FALSE;
				land_x=NULL;
				land_y=NULL;
				land_z=NULL;
				tType=SPACEPOD
				passengers[] = list()

		display = "{Go{x"
		text = "<font color=green>o</font>"

		proc
			warpArea(x,y,planet/A){

				if(!isplanet(A)) { A = locate(A); } // Find the area we were asked to locate to.

				if(isplanet(A)){
					if(x > A.getDX() || x < 1 || y > A.getDY() || y < 1){ // Check our area's boundaries to see if its a valid warp.
						game.logger.error("SPACEPOD ERROR: Invalid coordinates for area!")
						return FALSE;
					}

					loc=locate(((x - 1) + A.x),((y - 1) + A.y),A.z); // Take our areas minimum coordinates an add to which room we wish to warp to.
				}else{
					game.logger.error("SPACEPOD ERROR: Invalid planet.");
					return FALSE;
				}

				return TRUE;
			}

			destroy(mob/attacker,attack){
				for(var/mob/Player/mobRef in passengers){
					send("Your spacepod was destroyed by [attacker.raceColor(attacker.name)]'s [attack]!",mobRef);
					send("Your [attack] has destroyed [mobRef:raceColor(mobRef:name)]'s spacepod!",attacker);
					remPassenger(mobRef)
				}
				del(src)
			}

			addPassenger(mob/m){
				passengers += m;
				m.visible=FALSE;
			}

			remPassenger(mob/m){
				passengers -= m;
				m.visible=TRUE;
			}

			summon(lx,ly,lz){
				set waitfor = FALSE;

				var/planet/p = ref:getArea()

				if(p.locked || p.noSummon){
					send("{YSPACEPOD:{x {RERROR{x {Ycould not lock coordinates.{x",ref);
					destroy();
					return FALSE;
				}

				if(transit){send("Your spacepod is already in transit!",ref);return}
				transit=TRUE
				send("{YSPACEPOD: Coordinates received ({x{G[coord(ref:getX(),ref:loc.loc:getDX())]{x{Y.{x{G[coord(ref:getY(),ref:loc.loc:getDY())]{x{Y) Planet [ref:loc.loc:name]{Y.{x",ref)
				send("[ref:raceColor(ref:name)]'s spacepod rises into the air and takes off!",_ohearers(src,0))
				loc=locate(0,0,0)
				sleep(50)
				loc=locate(lx,ly,lz)
				if(ref && loc == ref:loc){
					send("Your spacepod [_msg()] infront of you!",ref);
					send("[ref:raceColor(ref:name)]'s spacepod [_msg()] infront of you!",a_oview_extra(0,src,ref))
				}else{
					send("[ref:raceColor(ref:name)]'s spacepod [_msg()] infront of you!",_ohearers(src,0))
				}
				transit=FALSE;

				return TRUE;
			}

			_msg(){
				if(loc:tType == WATER){
					return "splashes down into the water"
				}else{
					return "crashes into the ground"
				}
			}

			getStatus(){
				if(loc:tType == WATER){
					return "floating in the water"
				}else{
					return "landed here"
				}
			}

			checkOwner(){
				set waitfor = FALSE;
				while(ref){sleep(world.tick_lag)}
				del(src)
			}



		New(mob/Player/m){
			name = "[m.name] space pod"
			DISPLAY = "[m.raceColor(m.name)]'s spacepod"
			m.spacePod = src
			ref = m

			insideBuilding = m.insideBuilding

			summon(m.x,m.y,m.z)
			checkOwner()
		}