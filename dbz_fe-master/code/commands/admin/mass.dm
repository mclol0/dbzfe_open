Command/Wiz
	summonall
		name = "summonall";
		immCommand = 1
		immReq = 3
		format = "summonall";
		syntax = "{csummonall{x";
		priority = 2

		command(mob/user) {
			for(var/mob/Player/m in world){
				if(user.loc != m.loc){
					m.loc=user.loc
					send(buildMap(m,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),m)
					send("You bring [m.name] to you!",user)
					send("[m.name] appears before you!",_ohearers(m,0))
					send("You have been summoned by [user.name]!",m)
				}
			}
		}