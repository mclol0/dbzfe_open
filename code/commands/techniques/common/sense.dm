Command/Technique
	sense
		name = "sense"
		internal_name = "sense"
		format = "~sense; ?!searc(mob@planet_all)|?~searc(mob@planet_all)|?any";
		syntax = list("mobile | direction")
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		canUseWhileRESTING = TRUE;
		var/cdTime = 1 SECONDS;
		helpCategory = "Utility"
		helpDescription = "Sense the energy of a specific target, or of everyone in a given direction."

		command(mob/Player/user, argument) {
			var
				buffer[] = list()
				direction;

			if(user && istext(argument)){
				if(TextMatch("north",argument,1,1)){
					send("You gaze north.",user)
					send("[user.raceColor(user.name)] gazes north.",_ohearers(0,user))
					direction = "north";
					argument=list(NORTH,NORTHEAST,NORTHWEST);
				}
				else if(TextMatch("south",argument,1,1)){
					send("You gaze south.",user)
					send("[user.raceColor(user.name)] gazes south.",_ohearers(0,user))
					direction = "south";
					argument=list(SOUTH,SOUTHEAST,SOUTHWEST);
				}
				else if(TextMatch("east",argument,1,1)){
					send("You gaze east.",user)
					send("[user.raceColor(user.name)] gazes east.",_ohearers(0,user))
					direction = "east";
					argument=list(EAST,NORTHEAST,SOUTHEAST);
				}
				else if(TextMatch("west",argument,1,1)){
					send("You gaze west.",user)
					send("[user.raceColor(user.name)] gazes west.",_ohearers(0,user))
					direction = "west";
					argument=list(WEST,NORTHWEST,SOUTHWEST);
				}else{
					syntax(user,getSyntax());
					return;
				}

				var/c=0;

				for(var/mob/m in user.zMobs()){
					if(a_get_dir(user,m) in argument){
						if(!m.canSense(user)){ continue; }
						buffer += format_text("[user.enCheck(m,TRUE)][user.checkSkill(m,TRUE)]<al26>[m.raceColor(m.name)]</a><al16>{D[uppertext(game.dir2text(a_get_dir(user,m)))]{x</a><al17>{D[coord(m:x,m:loc.loc:getMaxX())]{x.{D[coord(m:y,m:loc.loc:getMaxY())]{x</a><al32>([skillMasteryFormatSensePower(user, m)])</a>\n");
						c++;
					}
				}

				if(!c){ buffer += "You sense no one to the [direction]..."; }

				send(implodetext(buffer,""),user)

			}else if(user && istype(argument,/mob)){
				if(!argument:canSense(user)){ syntax(user,getSyntax());;return FALSE}

				if(user.loc == argument:loc){
					buffer += "You sense [user.enCheck(argument)][user.checkSkill(argument)][argument:raceColor(argument:name)] ([skillMasteryFormatSensePower(user, argument)]) [game.dir2text(a_get_dir(user,argument))].\n"
				}else{
					buffer += "You sense [user.enCheck(argument)][user.checkSkill(argument)][argument:raceColor(argument:name)] ([skillMasteryFormatSensePower(user, argument)]) to the [game.dir2text(a_get_dir(user,argument))].\n"
				}
				send(implodetext(buffer,""),user)
			}else{
				var/c=0;

				for(var/mob/m in user.zMobs()){
					if(!m.canSense(user)){ continue; }
					buffer += format_text("[user.enCheck(m,TRUE)][user.checkSkill(m,TRUE)]<al26>[m.raceColor(m.name)]</a><al16>{D[uppertext(game.dir2text(a_get_dir(user,m)))]{x</a><al17>{D[coord(m:x,m:loc.loc:getMaxX())]{x.{D[coord(m:y,m:loc.loc:getMaxY())]{x</a><al32>([skillMasteryFormatSensePower(user, m)])</a>\n");
					c++;
				}

				if(!c){ buffer += "You sense no one..."; }

				send(implodetext(buffer,""),user)
			}

			skillMasteryGainExp(user, "sense", 1)
			game.addCooldown(user.name,internal_name,cdTime);
		}
