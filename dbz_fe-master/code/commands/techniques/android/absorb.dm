Command/Technique
	absorb
		name = "absorb"
		internal_name = "absorb"
		format = "~absorb";
		priority = 2
		_maxDistance = 0;
		tType = DEFENSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Android's unique skill. Extend your arm towards an incoming KI attack and absorb its energy nullifying its effects."
		skillDatum = /atkDatum/absorb

		command(mob/user) {
			if(user){
				new /atkDatum/absorb(user,user,src,(world.time + defenseDelay))
			}
			else{
				syntax(user,getSyntax());
			}
		}