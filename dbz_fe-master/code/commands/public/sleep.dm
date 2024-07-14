Command/Public
	doSleep
		name = "sleep"
		format = "~sleep";
		canUseWhileRESTING = TRUE;
		helpDescription = "Go to sleep and greatly increate your regeneration rate. While sleeping, you are unaware of your surroundings."

		command(mob/user) {
			if(user.sleeping){
				send("You are already sleeping!", user)
				return;
			}

			if(user.fCombat._hostiles()){
				send("You can't go to sleep right now!", user)
				return;
			}

			if(user.kiAttk){
				user.kiAttk:isCharging=FALSE;spawn(1){user.kiAttk:clean()}
			}

			if(user.curreng >= user.getMaxEN() && user.currpl >= user.getMaxPL()){
				send("You don't need to sleep!",user)
				return;
			}else{
				if(user.powering){user.powering=FALSE}
				if(user.atkDat) user.atkDat:user = NULL;
				send("You go to sleep!",user)
				send("[user.raceColor(user.name)] went to sleep!", _ohearers(0,user))
				if(!user.density){alaparser.parse(user, "fly", list());}
				user.powering = FALSE;
				user.barrier = FALSE;
				user.bursting = FALSE;
				user.resting = FALSE;
				user.sleeping = TRUE;
				user.sleeping()
			}
		}