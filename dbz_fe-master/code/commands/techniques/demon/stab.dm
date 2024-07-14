Command/Technique
	stab
		name = "stab"
		internal_name = "stab"
		format = "~stab; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,BARRIER)
		comboAble = TRUE;
		comboName = "st";
		helpCategory = "Advanced Combat"
		helpDescription = "Demon's unique skill. Using a materialized sword, stab your opponent's body."
		skillDatum = /atkDatum/stab 

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou take a stance and ready your blade for a lunge...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] takes a stance and begins to lunge at [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))
				send("{R* {x[user.raceColor(user.name)]{R takes a stance and begins to lunge at you...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/stab(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}