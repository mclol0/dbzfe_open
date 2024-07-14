Command/Wiz
	immwho
		name = "immwho";
		format = "immwho";
		syntax = "{cimmwho{x"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 1

		command(mob/user, text) {
			send("\n[game.name] {GWHOIS{x",user);
			send("-----------------------------------------------------------",user);
			for(var/mob/m in world){
				if(isplayer(m) || istype(m,/mob/cClient))
					send("[time(time=m.get_life())] \[[m.getClient()]\] - [m.raceColor(m.name)]",user);
			}
			send("-----------------------------------------------------------",user);
		}