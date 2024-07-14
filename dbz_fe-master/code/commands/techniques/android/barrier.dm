Command/Technique
	barrier
		name = "barrier"
		internal_name = "barrier"
		format = "~barrier";
		priority = 1
		_maxDistance = 0;
		tType = UTILITY;
		helpCategory = "Advanced Combat"
		helpDescription = "Create a barrier of energy around you to shield you from attacks."
		skillDatum = /atkDatum/utility/barrier

		command(mob/user) {
			if(user.barrier){
				user.barrier = FALSE;
			} else {
				send("Your barrier forms around you!",user)
				send("[user.raceColor(user.name)]'s shields form around [user.determineSex(2)]!", _ohearers(0,user))
				new skillDatum(user, src)
			}
		}