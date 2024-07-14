atkDatum/parry
	name = "parry"
	defense = TRUE

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
			user.cancelKi()
			send("You parry the air!",user)
			user.powering = FALSE;
			user.barrier = FALSE;
			if(user.simultaneous) ++user.aID
			defense = FALSE;
			if(user.fCombat && user.fCombat.lastTarget && isplayer(user.fCombat.lastTarget)){sleep(defenseLag_PVP)}else{sleep(defenseLag)}
		}
	}

atkDatum/parry/parry_high

	name = "parry high";

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			..()
			user.atkDat = src
		}
	}

atkDatum/parry/parry_low

	name = "parry low";

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			..()
			user.atkDat = src
		}
	}