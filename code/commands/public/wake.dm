Command/Public
	wake
		name = "wake"
		format = "~wake|~stand";
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		helpDescription = "Get back on your feet while sleeping or resting."

		command(mob/user) {
			if(!user.sleeping && !user.resting){
				send("You are already awake!",user)
				return FALSE;
			}

			if(user.sleeping){
				user.sleeping=FALSE;
			}
			if(user.resting){
				user.resting=FALSE;
			}
		}