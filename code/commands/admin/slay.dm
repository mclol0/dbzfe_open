Command/Wiz
	slay
		name = "slay";
		immCommand = 1
		immReq = 3
		format = "~slay; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cslay{x {c<{x{Cmobile{x{c>{x";
		canFinish = TRUE

		command(mob/user, mob/m) {
			if(m){
				if(user==m){
					send("You can't slay yourself dumbass!",user)
					return FALSE;
				}else{
					send("You have slain [m.raceColor(m.name)]!",user)
					m.currpl = MIN_PL
					m.death(user,src)
				}
			}
			else{
				syntax(user,syntax);
			}
		}