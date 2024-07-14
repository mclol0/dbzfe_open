Command/Public
	server
		name = "server";
		immCommand = 1
		immReq = 1
		format = "server";
		syntax = "{cserver{x";

		command(mob/user) {
			var/buffer[] = list()

			buffer += "=[game.name]=\n"
			if(user.isImm){
				buffer += "WORLD CPU USAGE: [eff_color(world.cpu,100)]\n"
			}
			buffer += "UPTIME: [time()]\n"
			if(DBDatum.COOLDOWN > 0){
				buffer += "EARTH DBS: [DBDatum.areActive() ? "{GACTIVE{x" : "{RINACTIVE{x"] ([time(DBDatum.COOLDOWN)])"
			}else{
				buffer += "EARTH DBS: [DBDatum.areActive() ? "{GACTIVE{x" : "{RINACTIVE{x"]"
			}

			if(DBDatum_NAMEK.COOLDOWN > 0){
				buffer += "\nNAMEK DBS: [DBDatum_NAMEK.areActive() ? "{GACTIVE{x" : "{RINACTIVE{x"] ([time(DBDatum_NAMEK.COOLDOWN)])"
			}else{
				buffer += "\nNAMEK DBS: [DBDatum_NAMEK.areActive() ? "{GACTIVE{x" : "{RINACTIVE{x"]"
			}

			if(event.EventMobRef && event.started){
				buffer += "\nEVENT MOB: [event.EventMobRef.raceColor(event.EventMobRef.name)] ([time(event.endTime - world.time)])";
			}else{
				buffer += "\nEVENT MOB: {RINACTIVE{x ([time(event.nextEventTime - world.time)])";
			}

			send(implodetext(buffer,""),user)
		}