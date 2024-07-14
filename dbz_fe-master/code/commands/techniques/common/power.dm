Command/Technique
	power
		name = "power"
		internal_name = "power"
		format = "~power; num|word";
		syntax = list("up | down | stop | number")
		priority = 2
		_maxDistance = 0;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Adjust your current powerlevel either up, down or to a specific number."

		command(mob/user, argument) {
			if(isnum(argument) && argument >= (MIN_PL + 1) && argument <= user.getMaxPL()){
				if(user.powering){
					send("You are already altering your powerlevel!",user)
					return FALSE;
				}

				if(argument > user.currpl){
					if(user.currpl >= user.getMaxPL()){
						send("You are already at your maximum!",user)
						return FALSE;
					}
					send("You begin to power up!",user)
					send("[user.name] begins to power up!",_ohearers(0,user))
				}else if(argument <= user.currpl){
					if(user.currpl <= MIN_PL + 1){
						send("You are already supressed!",user)
						return FALSE;
					}
					user.regenPL = FALSE;
					send("You begin to power down!",user)
					send("[user.name] begins to power down!",_ohearers(0,user))
				}

				user.powering = TRUE;
				user.power(argument)
			}
			else if(istext(argument)){
				if(TextMatch("up",argument,1,1)){
					if(user.powering){
						send("You are already altering your powerlevel!",user)
						return FALSE;
					}
					if(user.currpl >= user.getMaxPL()){
						send("You are already at your maximum!",user)
						return FALSE;
					}
					send("You begin to power up!",user)
					send("[user.name] begins to power up!",_ohearers(0,user))
					user.powering = TRUE;
					user.power(user.getMaxPL(),TRUE)
				}else if(TextMatch("down",argument,1,1)){
					if(user.powering){
						send("You are already altering your powerlevel!",user)
						return FALSE;
					}
					if(user.currpl <= MIN_PL + 1){
						send("You are already supressed!",user)
						return FALSE;
					}
					send("You begin to power down!",user)
					send("[user.name] begins to power down!",_ohearers(0,user))
					user.regenPL = FALSE;
					user.powering = TRUE;
					user.power(5);
				}else if(TextMatch("stop",argument,1,1)){
					if(!user.powering){
						send("You are not altering your powerlevel!",user)
						return FALSE;
					}
					user.powering = FALSE;
				}
			}
			else{
				syntax(user,getSyntax());
			}
		}