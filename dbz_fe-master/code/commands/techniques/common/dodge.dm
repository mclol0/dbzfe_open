Command/Technique
	dodge
		name = "dodge"
		internal_name = "dodge"
		format = "~dodge; ?word";
		syntax = list("left | right")
		priority = 2
		_maxDistance = 0;
		tType = DEFENSE;
		helpCategory = "Basic Combat"
		helpDescription = "Avoid receiving incoming attacks by moving your body out of harm's way."
		skillDatum = /atkDatum/dodge_left

		command(mob/user, direction) {

			direction = determineDodge(direction);

			if(direction){
				switch(direction){
					if(DODGE_LEFT){
						new /atkDatum/dodge_left(user,user,src,(world.time + defenseDelay))
					}

					if(DODGE_RIGHT){
						new /atkDatum/dodge_right(user,user,src,(world.time + defenseDelay))
					}
				}
			}
			else{
				syntax(user,getSyntax());
			}
		}