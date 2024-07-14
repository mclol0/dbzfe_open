Command/Public
	travel
		name = "travel"
		format = "~travel; word";
		syntax = list("EARTH | NAMEK | ARLIA | VEGETA | KAISHIN | FRIEZA | BAS | MOON")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = TRUE;
		helpDescription = "Travel to the desired destination while inside your space pod."

		command(mob/Player/user, planet) {
			if(user.spacePod && (user in user.spacePod:passengers)){
				planet=uppertext(planet)

				if(user.hasDB()){
					send("You can't perform this while holding the dragonballs!",user);
					return
				}

				if(user.traveling){
					send("You are already traveling to planet [user.spacePod:saveRef],",user)
					return
				}

				if(user && user.spacePod){
					if(TextMatch("NAMEK", planet, 1, 1)){
						if(user.z == 2){
							send("You are already on Planet Namek!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/namek)
						return
					}
					else if(TextMatch("MOON", planet, 1, 1)){
						if(get_area("earth's moon") == user.getArea()){
							send("You are already on planet Earth's moon!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/moon/earth)
					}
					else if(TextMatch("EARTH", planet, 1, 1)){
						if(user.z == 1){
							send("You are already on Planet Earth!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/earth)
					}
					else if(TextMatch("KAISHIN", planet, 1, 1)){
						if(user.z == 10){
							send("You are already on Planet Kaishin!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/kaishin)
					}
					else if(TextMatch("ARLIA", planet, 1, 1)){
						if(user.z == 6){
							send("You are already on Planet Arlia!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/arlia)
					}
					else if(TextMatch("VEGETA", planet, 1, 1)){
						if(user.z == 7){
							send("You are already on Planet Vegeta!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/vegeta)
					}else if(TextMatch("FRIEZA", planet, 1, 1)){
						if(user.z == 8){
							send("You are already on Planet Frieza!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/freezer)
					}else if(TextMatch("BAS", planet, 1, 1)){
						if(user.z == 13){
							send("You are already on Planet Bas!",user)
							return
						}
						user.locked = TRUE;
						send("{YSPACEPOD:{x You begin punching in the coordinates...",user,TRUE)
						sleep(30);
						user.locked = FALSE;
						send("[user.raceColor(user.name)]'s spacepod takes off into the air at fabulous speeds!",a_oview_extra(0,user.spacePod,user))
						user.spacePod:loc=global.planets[uppertext(rStrip_Escapes(user.getArea():name))];
						user.spacePod:travelTo(/planet/bas)
					}else{
						syntax(user,src);
						return
					}
				}
			}else{
				send("You are not in your space pod!",user)
			}
		}
