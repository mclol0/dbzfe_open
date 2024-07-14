atkDatum/self_destruct

	New(mob/caller,mob/objective,Command/c,gTime){
		user = caller
		user.atkDat = src
		target = objective
		AID = ++user.aID
		goTime = gTime
		command = c
		locked = TRUE;
		..()
	}

	go(){
		var/goTime = (world.time + 15);

		while(user && target){
			if(world.time >= goTime){
				user.fCombat.doDamage(target,50,80,"self destruct",command)
				user.fCombat.doDamage(user,1000,1000,"self destruct",command)
				//user._doDamage(-ret_percent(1000,user.currpl));
				break;
			}
			sleep(world.tick_lag)
		}
	}