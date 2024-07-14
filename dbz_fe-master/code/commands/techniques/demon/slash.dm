Command/Technique
	slash
		name = "slash"
		internal_name = "slash"
		format = "~slash; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,BARRIER)
		comboAble = TRUE;
		comboName = "sl";
		helpCategory = "Advanced Combat"
		helpDescription = "Demon's unique skill. Use a materialized sword to slash your enemy."
		skillDatum = /atkDatum/slash 

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou take a stance and ready your blade for a slash...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] takes a stance and begins to draw their sword towards [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))
				send("{R* {x[user.raceColor(user.name)]{R takes a stance and begins to draw their sword at you...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/slash(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}