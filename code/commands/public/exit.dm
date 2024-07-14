Command/Public
	exit
		name = "exit"
		format = "~exit; ~?searc(obj@container)|?word";
		syntax = list("pod | building | location")
		canAlwaysUSE = FALSE
		priority = 1;
		helpCategory = "Movement"
		helpDescription = "{CExit buildings, locations or special containers like space pods or medical pods. Use this while standing on the entrance of the location that you previously entered.{x"

		command(mob/Player/user, o) {
			if(user.x == 26 && user.y == 242 && user.z == 9){
				user.loc=locate(84,238,9);
				user.plCheck();
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/earth/UNDERWATER_LAKE)){
				user.loc=locate(11,242,1);
				user.plCheck();
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/earth/SILENT_BUBBLE)){
				user.loc=locate(231,111,1);
				user.plCheck();
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/moon/moon_lab_secret)){
				user.loc=locate(56,231,12);
				user.plCheck();
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/moon/moon_lab_lair)){
				user.loc=locate(123,156,5);
				user.plCheck();
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/moon/moon_lab_lair_basement)){
				user.loc=locate(94,151,5);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(user.x == 84 && user.y == 210 && user.z == 9){
				user.loc=locate(256,136,1);
				user.plCheck();
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user);
			}else if(istype(user.loc.loc,/planet/arena) && user.isSafe()){
				var/planet/arena/area = user.getArea();
				var/c = percent(user.currpl,user.getMaxPL())
				user.loc=locate(area.entranceX,area.entranceY,area.entranceZ);
				user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user);
			}else if(user.spacePod && checkPlane(user, user.spacePod) && (user.spacePod == o || TextMatch("pod", o, 1, 1))){
				if(!(user in user.spacePod:passengers)){
					send("You are not in your spacepod.",user)
					return
				}
				if(user.traveling){
					send("You are currently traveling to planet [user.spacePod:saveRef], You can't breath in space idiot!",user)
					return
				}

				if((user in user.spacePod:passengers)){
					send("You exit your spacepod.",user)
					send("[user.raceColor(user.name)] exit's [user.determineSex(1)] spacepod.",_ohearers(user,0))
					user.spacePod:remPassenger(user)
				}else{
					send("You are not in a spacepod!",user)
				}
			}else if (istype(o, houseSystem.UPGRADES[houseSystem.MEDPOD])) {
				o:exit(user)
			}else if (istype(user.loc, houseSystem.TURFS[houseSystem.ENTRANCE]) && houseSystem.canExitHouse(user)){
				user.insideBuilding = FALSE
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user);
				send("You exit the house and the door closes behind you.", user)
				send("[user.raceColor(user.name)] exits from the house and the door closes behind [user.determineSex(2)].", _ohearers(user, 0))
			}else{
				syntax(user, src);
			}
		}
