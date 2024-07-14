Command/Technique
	rocketpunch
		name = "rocketpunch"
		internal_name = "rocketpunch"
		format = "~rocketpunch; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 5;
		_minDistance = 0;
		tType = MELEE;
		defenses = list(DUCK,BARRIER)
		comboAble = FALSE;
		canSTUN = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Android's unique skill. Use hidden rockets in your wrists to propell your fist towards your enemy and deal a devastating blow."
		skillDatum = /atkDatum/rocketpunch

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {
			if(target && a_get_dist(user,target) > _maxDistance || !target){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}

			send("{B* You level your fist at {x[target.raceColor(target.name)]{B!{x\n",user)
			send("{R* {x[user.raceColor(user.name)]{R levels [user.determineSex(1)] fist at you!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] levels [user.determineSex(1)] fist at [target.raceColor(target.name)]!\n",a_oview_extra(0,user,target))

			new /atkDatum/rocketpunch(user,target,src,getAttackDelay(src, user.fCombat, target))

		}
