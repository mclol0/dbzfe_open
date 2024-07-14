Command/Wiz
	stats
		name = "stats";
		immCommand = 1
		immReq = 3
		format = "~stats; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cstats{x {c<{x{Cmobile{x{c>{x";
		priority = 2

		command(mob/user, mob/m) {
			if(m){
				m.stats(user);
			}
			else{
				syntax(user,syntax);
			}
		}