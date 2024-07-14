Command/Technique
	lure
		name = "lure"
		internal_name = "lure"
		format = "~lure; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 8;
		tType = MELEE;
		defenses = list(PARRY_HIGH)
		comboAble = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Demon's unique skill. Lasso your enemy with a whip and pull him over to you."
		skillDatum = /atkDatum/lure

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou toss your whip towards {x[target.raceColor(target.name)]{B...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] tosses their whip towards [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))
				send("{R* {x[user.raceColor(user.name)]{R tosses their whip towards you...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/lure(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}