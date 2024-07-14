Command/Technique
	wolf_fang_fist
		name = "wolffangfist"
		internal_name = "wolf fang fist"
		format = "~wolffangfist; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH,DUCK,BARRIER)
		comboAble = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Focusing your KI in your fists, deliver a powerful blow to your opponent to disorient him during the fight."
		skillDatum = /atkDatum/wolf_fang_fist

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou take the wolf stance and start glowing...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] takes the wolf stance and starts glowing...\n",a_oview_extra(0,user,target))
				send("{R* {x[user.raceColor(user.name)]{R takes the wolf stance and starts glowing...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/wolf_fang_fist(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}