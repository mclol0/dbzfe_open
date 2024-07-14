Command/Public
	doRest
		name = "rest"
		format = "~rest|~sit";
		canUseWhileRESTING = TRUE;
		priority = 2
		helpDescription = "Take a break by sitting down on the floor. This increases your healing rate slightly."

		command(mob/user) {
			if(user.sleeping){
				send("You are already sleeping!", user)
				return;
			}

			if(user.resting){
				send("You are already resting!", user)
				return;
			}

			if(user.kiAttk && !user.kiAttk:fired){
				user.kiAttk:isCharging=FALSE;spawn(1){user.kiAttk:clean()}
			}

			if(user.curreng >= user.getMaxEN()){
				send("You don't need to rest!",user)
				return;
			}else{
				if(user.atkDat) user.atkDat:user = NULL;
				if(user.kiAttk && user.kiAttk:isCharging){user.kiAttk:isCharging=FALSE;spawn(1){user.kiAttk:clean()}}
				if(user.powering){user.powering=FALSE}
				send("You sit down and begin to rest!",user)
				send("[user.raceColor(user.name)] sits down and begins to rest!", _ohearers(0,user))
				if(!user.density){alaparser.parse(user, "fly", list());}
				user.powering = FALSE;
				user.barrier = FALSE;
				user.bursting = FALSE;
				user.resting = TRUE;
				user.resting()
			}
		}