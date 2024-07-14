Command/Technique
	tail_whip
		name = "tailwhip"
		internal_name = "tail whip"
		format = "~tailwhip; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH,DUCK,SWEEP,BARRIER)
		comboAble = TRUE;
		comboName = "tw";
		helpCategory = "Advanced Combat"
		helpDescription = "Using your tail, quickly swing it against your opponent in a powerful attack to the upper portion of his body."
		skillDatum = /atkDatum/tail_whip

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou swing your tail at {x[target.raceColor(target.name)]{B...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] swings [user.determineSex(1)] tail at [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))
				send("{R*{x [user.raceColor(user.name)]{R swings [user.determineSex(1)] tail at you...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/tail_whip(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}