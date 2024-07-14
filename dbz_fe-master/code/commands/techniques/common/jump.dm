Command/Technique
	jump
		name = "jump"
		internal_name = "jump"
		format = "~jump";
		priority = 2
		_maxDistance = 0;
		tType = DEFENSE;
		helpCategory = "Basic Combat"
		helpDescription = "Avoid damage by jumping over attacks aimed at your legs."
		skillDatum = /atkDatum/jump

		command(mob/user) {
			if(user){
				new /atkDatum/jump(user,user,src,(world.time + defenseDelay))
			}
			else{
				syntax(user,getSyntax());
			}
		}