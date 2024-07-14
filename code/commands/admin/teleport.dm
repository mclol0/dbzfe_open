Command/Wiz
	teleport
		name = "teleport";
		immCommand = 1
		immReq = 1
		format = "~teleport; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cteleport{x {c<{x{Cmobile{x{c>{x";
		priority = 100

		command(mob/user, mob/m) {
			if(m){
				if(user.loc == m.loc){
					send("You are already at [m.raceColor(m.name)]'s location!",user)
				}else{
					send("[user.raceColor(user.name)] vanishes into thin air!",_ohearers(user,0))
					user.loc=m.loc
					send("[user.raceColor(user.name)] appears before you!",_ohearers(user,0))
					send(buildMap(user,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),user)
					send("You warp to [m.raceColor(m.name)]!",user)
				}
			}
			else{
				syntax(user,syntax);
			}
		}