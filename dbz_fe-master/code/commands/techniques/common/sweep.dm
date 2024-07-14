Command/Technique
	sweep
		name = "sweep"
		internal_name = "sweep"
		format = "~sweep; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_LOW,JUMP,SPIN_KICK,BARRIER)
		comboAble = TRUE;
		comboName = "swe";
		helpCategory = "Basic Combat"
		helpDescription = "Basic melee attack. Turn around while crouching, attempting to kick the legs from under your opponent."
		skillDatum = /atkDatum/sweep

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou begin a low sweeping motion...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] begins a low sweeping motion...\n",a_oview_extra(0,user,target))
				send("{R* {x[target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a low sweeping motion...{x"] [target.defenseTips(src)]\n",target)


				new /atkDatum/sweep(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}
