atkDatum/jump

	name = "jump";
	cost = 1

	defense = TRUE;

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			if(!user.simultaneous) AID = ++user.aID
			goTime = gTime
			command = c
			locked = TRUE;
			..()
		}
	}

	go(){
		if(defense){
			user._doEnergy(-getCost())
			user.cancelKi()
			send("You jump in the air!",user)
			user.barrier = FALSE;
			user.powering = FALSE;
			if(user.simultaneous) ++user.aID
			defense = FALSE;
			if(user.fCombat && user.fCombat.lastTarget && isplayer(user.fCombat.lastTarget)){sleep(defenseLag_PVP)}else{sleep(defenseLag)}
		}
	}