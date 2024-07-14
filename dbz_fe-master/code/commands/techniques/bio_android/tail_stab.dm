Command/Technique
	tail_stab
		name = "tailstab"
		internal_name = "tailstab"
		format = "~tailstab; ?~searc(mob@melee_range_2)";
		syntax = list("mobile")
		priority = 5
		_maxDistance = 1;
		tType = MELEE;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,BARRIER)
		canFinish = FALSE;
		comboAble = TRUE;
		comboName = "ts";
		helpCategory = "Advanced Combat"
		helpDescription = "Use your tail to stab your opponent."
		skillDatum = /atkDatum/tail_stab 

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {
			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				send("{B*{x {BYou aim your tail and prepare to strike...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] aims [user.determineSex(1)] tail and prepares to strike...\n",a_oview_extra(0,user,target))
				send("{R* {x[user.raceColor(user.name)]{R aims [user.determineSex(1)] tail and prepares to strike...{x [target.defenseTips(src)]\n",target)

				new /atkDatum/tail_stab(user,target,src,getAttackDelay(src, user.fCombat, target))

			}
			else{
				syntax(user, getSyntax())
			}
		}
