Command/Wiz
	event
		name = "event";
		immCommand = 1
		immReq = 2
		format = "event";
		syntax = "{cevent{x"

		command(mob/user) {
			if(!event.started){
				event.nextEventTime = (world.time + 1 SECONDS);
				event.endTime = (world.time + 30 MINUTES);
			}else{
				send("There is an event already taking place!",user,TRUE);
			}
		}