Command/Technique
	parry
		name = "parry"
		internal_name = "parry"
		format = "~parry; ?word";
		syntax = list("high | low")
		priority = 5
		_maxDistance = 0;
		tType = DEFENSE;
		helpCategory = "Basic Combat"
		helpDescription = "Using your arms and legs, intercept incoming attacks and avoid receiving damage from your opponent."
		skillDatum = /atkDatum/parry

		command(mob/user, direction) {

			direction = determineParryHighLow(direction);

			if(direction){
				switch(direction){
					if(PARRY_HIGH){
						new /atkDatum/parry/parry_high(user,user,src,(world.time + defenseDelay))
					}

					if(PARRY_LOW){
						new /atkDatum/parry/parry_low(user,user,src,(world.time + defenseDelay))
					}
				}
			}
			else{
				syntax(user, getSyntax());
			}
		}