Command/Technique
	fly
		name = "fly"
		internal_name = "fly"
		format = "~fly; ?!searc(mob@planet)|?~searc(mob@planet)|?any";
		priority = 2;
		skillCommand = TRUE;
		canUseWhileRESTING=TRUE
		helpCategory = "Movement"
		helpDescription = "Raise to the sky and move around without limits by using your ki to propel you in any direction you desire. This technique requires certain concentration and will drain your energy over time."
		syntax = list("nothing | mob | <1-5> direction | X.Y")

		command(mob/user, argX) {
			var
				syntax_1 = "{cfly{x {c<{x{C1-[user.calcBonusFly()]{x{c>{x {c<{x{CN|S|W|E{x{c>{x";
				syntax_2 = "{cfly{x {c<{x{Cmobile{x{c>{x";
				syntax_3 = "{cfly{x {c<{x{Cx{x{c>{x {c<{x{Cy{x{c>{x";
				traveled = 1;

			if(user.insideBuilding){
				send("You can't fly inside a building",user,TRUE);
				return
			}

			if(user.resting){
				send("You are resting!",user)
				return
			}

			if("Exit." in user.Exits()){
				send("You need to exit your container first",user)
				return
			}

			if(!argX){
				if(user.density){
					if(user.loc:tType == WATER){
						send("You rise out of the water, and into the sky.", user)
						send("[user.raceColor(user.name)] rises out of the water, and into the sky.", _ohearers(0, user))
					}
					else{
						send("You rise into the sky.", user)
						send("[user.raceColor(user.name)] rises into the sky.", _ohearers(0, user))
					}
					user.density = FALSE;
					user.icon_state = "Flight";
					if(isplayer(user)) user.fly();
				}
				else{
					if(user.loc:tType == WATER){
						send("You fall into the water.", user)
						send("[user.raceColor(user.name)] falls into the water.", _ohearers(0, user))
					}
					else{
						send("You fall to the ground.", user)
						send("[user.raceColor(user.name)] falls to the ground.", _ohearers(0, user))
					}
					user.flying=NULL;
					user.lFlyT=NULL;
					user.icon_state = "";
					user.density = TRUE;
				}
			}else if(user.flying && argX=="stop"){
				user.flying=NULL;
				user.lFlyT=NULL;
			}else if((lowertext(argX) in list("north","northeast","northwest","east","west","south","southeast","southwest"))){
				var/finalDirection = NULL;

				if(user.checkTargeted()){
					send("Umph, I can't go that way!",user)
					return
				}

				switch(lowertext(argX)){
					if("north"){ finalDirection = NORTH; }
					if("northeast"){ finalDirection = NORTHEAST; }
					if("northwest"){ finalDirection = NORTHWEST; }
					if("east"){ finalDirection = EAST; }
					if("west"){ finalDirection = WEST; }
					if("south"){ finalDirection = SOUTH; }
					if("southeast"){ finalDirection = SOUTHEAST; }
					if("southwest"){ finalDirection = SOUTHWEST; }
				}

				if(user.density){
					alaparser.parse(user, "fly", list());
				}

				if(!user.density){
					if(user){
						if(user.lFlyT){ send("You stop flying towards [user.lFlyT:raceColor(user.lFlyT:name)]!",user); }
						send("You begin flying [argX]!",user);
						user.flying = user;
						user.lFlyT = user;
						user.flyDirection(user,finalDirection);
					}
				}else{
					send("You are not flying!",user)
				}
			}else if(isnum(text2num(fetchArg(text2list(argX,"."),1))) && isnum(text2num(fetchArg(text2list(argX,"."),2)))){
				if(user.checkTargeted()){
					send("Umph, I can't go that way!",user)
					return
				}

				if(user.density){
					alaparser.parse(user, "fly", list());
				}

				if(!user.density){
					if(user){

						var
							coords = text2list(argX,".");
							realX = user.loc.loc:getRealX(text2num(coords[1]));
							realY = user.loc.loc:getRealY(text2num(coords[2]));
							location = locate(realX,realY,user.z);

						if(user.loc != location){

							if(user.loc == location){
								send("You're already flying towards [coords[1]]{C.{x[coords[2]]!",user);
								return;
							}

							if(user.lFlyT){ send("You stop flying towards [user.lFlyT:raceColor(user.lFlyT:name)]!",user); }
							send("You begin flying towards [coords[1]]{C.{x[coords[2]]!",user);
							user.flying = location;
							user.lFlyT = location;
							user.flyToCoord(location);
						}else{
							send("You are already at [coords[1]]{C.{x[coords[2]]!",user);
						}
					}else{
						syntax(user,syntax_3);
					}
				}else{
					send("You are not flying!",user)
				}
			}else if(isnum(text2num(fetchArg(text2list(argX," "),1)))){
				var/list/argz = text2list(argX," ");
				if(user.flying){user.flying=NULL;user.lFlyT=NULL;}

				if(user.density){
					alaparser.parse(user, "fly", list());
				}

				if(text2num(argz[1]) > user.calcBonusFly()){
					send("Syntax: [syntax_1]",user)
					return
				}

				if(TextMatch("north", argz[2], 1, 1)){
					if("north" in user.Exits()){user._doEnergy(-1);send("You fly north.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("north" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,NORTH), NORTH)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("east", argz[2], 1, 1)){
					if("east" in user.Exits()){user._doEnergy(-1);send("You fly east.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("east" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,EAST), EAST)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("west", argz[2], 1, 1)){
					if("west" in user.Exits()){user._doEnergy(-1);send("You fly west.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("west" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,WEST), WEST)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("south", argz[2], 1, 1)){
					if("south" in user.Exits()){user._doEnergy(-1);send("You fly south.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("south" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,SOUTH), SOUTH)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("ne", argz[2], 1, 1)){
					if("ne" in user.Exits()){user._doEnergy(-1);send("You fly northeast.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("ne" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,NORTHEAST), NORTHEAST)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("nw", argz[2], 1, 1)){
					if("nw" in user.Exits()){user._doEnergy(-1);send("You fly northwest.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("nw" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,NORTHWEST), NORTHWEST)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("se", argz[2], 1, 1)){
					if("se" in user.Exits()){user._doEnergy(-1);send("You fly southeast.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("se" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,SOUTHEAST), SOUTHEAST)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else if(TextMatch("sw", argz[2], 1, 1)){
					if("sw" in user.Exits()){user._doEnergy(-1);send("You fly southwest.", user)}else{send("Umph, I can't go that way!",user);return FALSE}
					while(traveled < text2num(argz[1]) + 1){
						if("sw" in user.Exits()){
							++traveled
							var/obj/trail/A = new(user.loc)
							A.setDisplay(gForm.getAuraColor(user,user.form,"~"))
							user.Move(get_step(user,SOUTHWEST), SOUTHWEST)
						}
						else{
							traveled = text2num(argz[1]) + 1
							send("Umph, I can't go that way!",user)
						}
					}
				}
				else{
					send("Syntax: [syntax_1]",user);
					return
				}

				send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
			}else if(ismob(argX) && argX:canSense(user)){
				if(user.checkTargeted()){
					send("Umph, I can't go that way!",user)
					return
				}

				if(user.density){
					alaparser.parse(user, "fly", list());
				}

				if(!user.density){
					if(user){
						if(user.loc != argX:loc){
							if(user.lFlyT == argX){
								send("You're already flying towards [user.lFlyT:raceColor(user.lFlyT:name)]!",user);
								return;
							}

							if(user.lFlyT){ send("You stop flying towards [user.lFlyT:raceColor(user.lFlyT:name)]!",user); }
							send("You begin flying towards [argX:raceColor(argX:name)]!",user);
							user.flying = argX;
							user.lFlyT = argX;
							user.flyTo(argX);
						}else{
							send("You are already at [argX:raceColor(argX:name)]'s location!",user);
						}
					}else{
						syntax(user,syntax_2);
					}
				}else{
					send("You are not flying!",user)
				}
			}else{
				syntax(user,syntax_2);
			}
		}