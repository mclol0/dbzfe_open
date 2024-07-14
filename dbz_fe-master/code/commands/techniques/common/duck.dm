Command/Technique
	duck
		name = "duck"
		internal_name = "duck"
		format = "~duck";
		syntax = "{cduck{x"
		priority = 2
		_maxDistance = 0;
		tType = DEFENSE;
		helpCategory = "Basic Combat"
		helpDescription = "Duck under attacks that are aimed at the upper portion of your body."
		skillDatum = /atkDatum/duck

		command(mob/user) {
			if(user){
				new /atkDatum/duck(user,user,src,(world.time + defenseDelay))
			}
			else{
				syntax(user,syntax);
			}
		}