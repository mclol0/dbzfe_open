Command/Wiz
	resetcds
		name = "resetcds";
		immCommand = 1
		immReq = 2
		format = "~resetcds; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cresetcds{x {c<{x{Cmobile{x{c>{x";

		command(mob/user, mob/m) {
			if(m){
				send("You reset [m.name]'s cooldowns!",user,TRUE)
				cCooldowns(m.name);
			}
			else{
				syntax(user,syntax);
			}
		}