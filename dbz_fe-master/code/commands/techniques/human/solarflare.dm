Command/Technique
	solar_flare
		name = "solarflare"
		internal_name = "solar flare"
		format = "~solarflare; ~searc(mob@planet)";
		syntax = list("mobile")
		_maxDistance = 8
		_minDistance = 0
		priority = 3
		tType = ENERGY;
		defenses = NULL
		helpCategory = "Advanced Combat"
		helpDescription = "Focus your KI into a flash of light to blind your opponent for a short period of time."
		skillDatum = /fEAttk/solarflare

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {
			if(target && a_get_dist(user,target) > _maxDistance || !target){
				syntax(user,getSyntax());
				return
			}

			if(target){
				if(..(user,target,TRUE,name)){
					return;
				}

				alaparser.parse(user, "yell SOLAR FLARE!!!!!", list());

				new /fEAttk/solarflare(user, target, src)
			}
			else{
				syntax(user, getSyntax())
			}
		}