Command/Wiz
	snoop
		name = "snoop";
		immCommand = 1
		immReq = 1
		format = "~snoop; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{csnoop{x {c<{x{Cmobile{x{c>{x";

		command(mob/user, mob/m){
			if(m){
				if(!m.snooper){
					if(user.snooping){
						send("You are no longer snooping [user.snooping:raceColor(user.snooping:name)]!",user)
						user.snooping:snooper = NULL;
						user.snooping = NULL;
					}

					user.snooping = m
					m.snooper = user
					send("You are now snooping [m.raceColor(m.name)]!",user)
				}else{
					send("[m.raceColor(m.name)] is already being snooped by [m.snooper]!",user)
				}
			}
			else{
				syntax(user,syntax);
			}
		}