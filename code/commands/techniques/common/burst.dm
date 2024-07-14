Command/Technique
	burst
		name = "burst"
		internal_name = "burst"
		format = "~burst";
		priority = 1
		_maxDistance = 0;
		iCommand = FALSE;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Use your Ki to provide you a burst of speed and be able to fly faster."

		command(mob/user) {
			if(user.bursting){
				user.bursting = FALSE;
			} else {
				send("[user.raceColor("Your aura bursts out around you!")]",user)
				send("[user.raceColor("[user.name]'s aura bursts out around [user.determineSex(2)]!")]", _ohearers(0,user))
				user.bursting = TRUE;
				user.bursting()
			}
		}