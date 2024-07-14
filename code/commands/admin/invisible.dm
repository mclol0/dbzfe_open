Command/Wiz
	invisible
		name = "invisible";
		immCommand = 1
		immReq = 1
		format = "~invisible";
		priority = 2;

		command(mob/user) {
			if(!user.invisible){
				send("You are now invisible!",user)
				user.invisible=TRUE
			}
			else{
				send("You are now visible!",user)
				user.invisible=FALSE
			}

		}