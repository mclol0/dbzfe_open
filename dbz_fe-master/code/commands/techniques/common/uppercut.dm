Command/Technique
	uppercut
		name = "uppercut"
		internal_name = "uppercut"
		format = "~uppercut; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_LOW,DODGE_LEFT,DODGE_RIGHT,BARRIER)
		comboAble = TRUE;
		comboName = "up";
		helpCategory = "Advanced Combat"
		helpDescription = "Advanced melee attack. Throw a powerful upward punch that can lift your enemy to the air."
		skillDatum = /atkDatum/uppercut 

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou launch an [name] at {x[target.raceColor(target.name)]{B...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] launches an [name] at [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))
				send("{R*{x [user.raceColor(user.name)]{R launches an [name] at you...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/uppercut(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}