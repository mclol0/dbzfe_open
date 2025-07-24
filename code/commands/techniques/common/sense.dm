Command/Technique
	sense
		name = "sense"
		internal_name = "sense"
		format = "~sense; ?!searc(mob@planet_all)|?~searc(mob@planet_all)|?any";
		syntax = list("mobile | direction | on | off | status | number | estimation")
		priority = 2
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		canUseWhileRESTING = TRUE;
		var/cdTime = 1.5 SECONDS;
		helpCategory = "Utility"
		helpDescription = "Sense the energy of a specific target, or of everyone in a given direction. You can also toggle power level sensing, or change the mode of power level sensing."

		command(mob/Player/user, argument) {
			var
				buffer[] = list()
				direction;

			if(istext(argument) && (lowertext(argument) == "on" || lowertext(argument) == "off" || lowertext(argument) == "status")) {
				var/obj/item/i = user.equipment[EYE]

				var/msg_on = ""
				var/msg_off = ""
				var/msg_status_on = ""
				var/msg_status_off = ""

				if(i && isScanner(i)) {
					msg_on = "You activate [i.DISPLAY]."
					msg_off = "You deactivate [i.DISPLAY]."
					msg_status_on = "[i.DISPLAY] is currently ON."
					msg_status_off = "[i.DISPLAY] is currently OFF."
				} else {
					send("You do not have a power level sensing device equipped.", user)
					return
				}
					
				if(lowertext(argument) == "on") {
					user.sensePL = TRUE
					send(msg_on, user)
					return
				} else if(lowertext(argument) == "off") {
					user.sensePL = FALSE
					send(msg_off, user)
					return
				} else if(lowertext(argument) == "status") {
					if(user.sensePL)
						send(msg_status_on, user)
					else
						send(msg_status_off, user)
					return
				}
			}

			if(istext(argument) && (lowertext(argument) == "number" || lowertext(argument) == "estimation")) {
				if(lowertext(argument) == "number") {
					user.sensePLMode = "number"
					send("You will now see numeric power levels when possible.", user)
				} else {
					user.sensePLMode = "estimation"
					send("You will now see qualitative estimations of power levels.", user)
				}
				return
			}

			if (game.checkCooldown(user.name,internal_name)) {
				send("You can't use [name] for another [num2text((game.coolDowns["([user.name])[internal_name]"] - world.time) / 10,3)] second(s)!",user)
				return
			}

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
						buffer += format_text("[user.enCheck(m,TRUE)][user.checkSkill(m,TRUE)]<al26>[m.raceColor(m.name)]</a><al16>{D[uppertext(game.dir2text(a_get_dir(user,m)))]{x</a><al17>{D[coord(m:x,m:loc.loc:getMaxX())]{x.{D[coord(m:y,m:loc.loc:getMaxY())]{x</a><al32>([formatSensePower(user, m)])</a>\n");
						c++;
					}
				}

				if(!c){ buffer += "You sense no one to the [direction]..."; }

				send(implodetext(buffer,""),user)

			}else if(user && istype(argument,/mob)){
				if(!argument:canSense(user)){ syntax(user,getSyntax());;return FALSE}

				if(user.loc == argument:loc){
					buffer += "You sense [user.enCheck(argument)][user.checkSkill(argument)][argument:raceColor(argument:name)] ([formatSensePower(user, argument)]) [game.dir2text(a_get_dir(user,argument))].\n"
				}else{
					buffer += "You sense [user.enCheck(argument)][user.checkSkill(argument)][argument:raceColor(argument:name)] ([formatSensePower(user, argument)]) to the [game.dir2text(a_get_dir(user,argument))].\n"
				}
				send(implodetext(buffer,""),user)
			}else{
				var/c=0;

				for(var/mob/m in user.zMobs()){
					if(!m.canSense(user)){ continue; }
					buffer += format_text("[user.enCheck(m,TRUE)][user.checkSkill(m,TRUE)]<al26>[m.raceColor(m.name)]</a><al16>{D[uppertext(game.dir2text(a_get_dir(user,m)))]{x</a><al17>{D[coord(m:x,m:loc.loc:getMaxX())]{x.{D[coord(m:y,m:loc.loc:getMaxY())]{x</a><al32>([formatSensePower(user, m)])</a>\n");
					c++;
				}

				if(!c){ buffer += "You sense no one..."; }

				send(implodetext(buffer,""),user)
			}

			if (!user.sensePL || user.sensePL && (isAndroid(user) || user.hasSkill("perception"))) {
				skillMasteryGainExp(user, "sense", 1)
			}
			game.addCooldown(user.name,internal_name,cdTime);
		}
