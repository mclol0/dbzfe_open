Command/Wiz
	bring
		name = "bring";
		immCommand = 1
		immReq = 1
		format = "~bring; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cbring{x {c<{x{Cmobile{x{c>{x";
		priority = 2

		command(mob/user, mob/m) {
			if(m){
				if(user.loc == m.loc){
					send("[m.name] is already at your location!",user)
				}
				else{
					m.loc=user.loc
					m.insideBuilding = user.insideBuilding
					send(buildMap(m,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),m)
					send("You bring [m.name] to you!",user)
					send("[m.name] appears before you!",_ohearers(m,0))
					send("You have been summoned by [user.name]!",m)
				}
			}
			else{
				syntax(user,syntax);
			}
		}