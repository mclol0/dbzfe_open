Command/Technique
	stone_spit
		name = "stonespit"
		internal_name = "stonespit"
		format = "~stonespit; ~searc(mob@planet)";
		syntax = list("mobile")
		priority = 3
		_maxDistance = 0;
		_minDistance = 0;
		tType = ENERGY;
		helpCategory = "Advanced Combat"
		helpDescription = "Demon's unique skill. Spit on your opponent, causing your saliva to convert them into stone, disabling him for a short period of time."
		skillDatum = /atkDatum/stonespit

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(target && a_get_dist(user,target) > _maxDistance || target && a_get_dist(user,target) < _minDistance || !target){
				syntax(user, getSyntax())
				return
			}

			if(target){
				if(..(user,target,TRUE,name)){
					return;
				}

				new /atkDatum/stonespit(user, target, src, world.time)
			}
		}