atkDatum
	deflect
		name = "deflect";

		defense = TRUE;

		New(mob/caller,mob/objective,Command/c,gTime){
			if (caller && objective) {
				user = caller
				user.atkDat = src
				target = objective
				//AID = ++user.aID
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
				send("You deflect the air!",user)
				user.powering = FALSE;
				user.barrier = FALSE;
				if(user.simultaneous) ++user.aID
				defense = FALSE;
				if(user.fCombat && user.fCombat.lastTarget && isplayer(user.fCombat.lastTarget)){sleep(defenseLag_PVP)}else{sleep(defenseLag)}
			}
		}