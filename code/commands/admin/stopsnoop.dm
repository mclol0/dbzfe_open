Command/Wiz
	stopsnoop
		name = "stopsnoop";
		immCommand = 1
		immReq = 1
		format = "stopsnoop";
		syntax = "{csnoop{x {c<{x{Cmobile{x{c>{x";

		command(mob/user, mob/m) {
			if(user.snooping){
				send("You are no longer snooping [user.snooping:raceColor(user.snooping:name)]!",user)
				user.snooping:snooper = NULL;
				user.snooping = NULL;
			}else{
				send("You're not snooping anyone!",user)
				return FALSE;
			}
		}