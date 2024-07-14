Command/Wiz
	restore
		name = "restore";
		immCommand = 1
		immReq = 1
		format = "~restore; !searc(mob@mobiles)|~searc(mob@mobiles) | any;";
		syntax = "{crestore{x {c<{x{Cmobile {c|{C all{c>{x";
		canAlwaysUSE = TRUE

		command(mob/user, mob/m) {
			if(m){
				if(lowertext(m) == "all") {
					for(var/mob/Player/p in game.players){
						p.restore()
						send("You have restored [p.name]!", user);
						send("{YYou feel an otherworldly presence restore you!{x", p)
					}
				} else {
					m.restore()
					send("You have restored [m.name]!",user)
					send("{YYou feel an otherworldly presence restore you!{x{x",m)
				}
			}
			else{
				syntax(user,syntax);
			}
		}
