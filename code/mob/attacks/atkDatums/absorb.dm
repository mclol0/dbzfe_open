atkDatum/absorb

	name = "absorb";

	defense = TRUE;

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			locked = TRUE;
			..()
		}
	}

	go(){
		if(defense){
			user.cancelKi()
			send("You absorb the air!",user)
			defense = FALSE;
			if(user.fCombat && user.fCombat.lastTarget && isplayer(user.fCombat.lastTarget)){sleep(defenseLag_PVP)}else{if(user.fCombat && user.fCombat.lastTarget && isplayer(user.fCombat.lastTarget)){sleep(defenseLag_PVP)}else{sleep(defenseLag)}}
		}
	}