Command/Public
	enter
		name = "enter"
		format = "~enter; ~?searc(obj@container)|?word";
		syntax = list("pod | building | location")
		helpCategory = "Movement"
		helpDescription = "{CEnter buildings, locations or special containers like space pods or medical pods. Building or houses entrances are denoted by a {Y%{x {Ccharacter on the map, while special locations are found throughout the map.{x"
		canAlwaysUSE = FALSE

		command(mob/Player/user, o) {
			if(!user.density){
				user.density = TRUE;
			}

			if(istype(user.loc,/turf/earth/HBTC)){
				user.loc=locate(26,242,9);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/earth/UNDERWATER_LAKE)){
				user.loc=locate(97,197,5);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/earth/SILENT_BUBBLE)){
				user.loc=locate(86,187,5);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/moon/moon_lab_secret)){
				user.loc=locate(123,147,5);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/moon/moon_lab_lair)){
				user.loc=locate(107,151,5);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/moon/moon_lab_lair_basement)){
				user.loc=locate(82,149,5);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(istype(user.loc,/turf/earth/korins_tower)){
				user.loc=locate(67,44,9);
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(TextMatch("arena", o, 1, 1)){
				var/entered=FALSE;

				for(var/planet/arena/a){
					if(user.x == a.entranceX && user.y == a.entranceY){
						var/c = percent(user.currpl,user.getMaxPL())
						user.loc=locate(a.exitX,a.exitY, 5);
						entered = TRUE;
						user.currpl = clamp(ret_percent(c,user.getMaxPL()), 5, user.getMaxPL())
						send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
						break;
					}
				}

				if(!entered){
					syntax(user, src);
				}

			}else if(istype(o,/obj/spacepod)){
				if(user.spacePod != o){
					send("That isn't your spacepod!",user)
					return;
				}

				if(user.checkLocked()){
					send("You can't enter your spacepod right now!",user)
					return;
				}

				if(!user.density){
					send("You should try landing first!",user);
					return;
				}

				if(!(user in user.spacePod:passengers)){
					send("You enter your spacepod.",user)
					send("[user.raceColor(user.name)] enters [user.determineSex(1)] spacepod.",_ohearers(user,0))
					user.spacePod:addPassenger(user)
				}else{
					send("You are already in your spacepod!",user)
				}
			}else if(istype(o, houseSystem.UPGRADES[houseSystem.MEDPOD])) {
				o:enter(user)
			}else if (istype(user.loc, houseSystem.TURFS[houseSystem.ENTRANCE]) && houseSystem.canEnterHouse(user)){
				send("You enter through the door and close it behind you.", user)
				send("[user.raceColor(user.name)] enters through the door and closes it behind [user.determineSex(2)].", _ohearers(user, 0))
				user.insideBuilding = user.loc:instanceId
				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else{
				syntax(user, src);
			}
		}
