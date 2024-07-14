Command/Public
	talk
		name = "talk"
		format = "~talk; ?!searc(mob@all_mob_loc) | ?~searc(mob@all_mob_loc)";
		syntax = list("mobile")
		canUseWhileRESTING = FALSE;
		priority=2
		helpDescription = "Start a conversation with special NPCs."

		command(mob/user, mob/NPA/target) {
			if(target && isloc(user,target)){
				if(user.density != target.density){
					if(!user.density){
						send("You can't talk to them while you're flying!",user,TRUE);
					}else{
						send("You can't talk to them while they're flying!",user,TRUE);
					}

					return FALSE;
				}else{
					target.initChat(user);
				}

				return TRUE;
			}
			else{
				send("Who are you trying to talk to?",user,TRUE);
			}
		}