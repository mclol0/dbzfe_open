Command/Technique
	deflect
		name = "deflect"
		internal_name = "deflect"
		format = "~deflect";
		priority = 2
		_maxDistance = 0;
		tType = DEFENSE;
		helpCategory = "Basic Combat"
		helpDescription = "Use your body to deflect incoming KI attacks."
		skillDatum = /atkDatum/deflect

		command(mob/user) {
			if(user){
				new /atkDatum/deflect(user,user,src,(world.time + defenseDelay))
			}
			else{
				syntax(user, getSyntax());
			}
		}