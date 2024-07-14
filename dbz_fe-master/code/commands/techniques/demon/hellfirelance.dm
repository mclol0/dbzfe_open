Command/Technique
	hellfirelance
		name = "hellfirelance"
		internal_name = "hellfirelance"
		format = "~hellfirelance; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 4;
		_minDistance = 0;
		tType = MELEE;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "Advanced Combat"
		helpDescription = "Focus your KI in your hands and create a lance of hellish fire to hit your opponent."
		skillDatum = /atkDatum/hellfirelance

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(target && a_get_dist(user,target) > _maxDistance || !target){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}

			send("{B* Your fist bursts into flame as you grin at {x[target.raceColor(target.name)]{B!{x\n",user)
			send("{R* {x[user.raceColor(user.name)]{R grins at you as [user.determineSex(1)] fist bursts into flame!{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)]'s first bursts into flame and [user.determineSex(1)] grins at [target.raceColor(target.name)]!\n",a_oview_extra(0,user,target))

			new /atkDatum/hellfirelance(user,target,src,getAttackDelay(src, user.fCombat, target))

		}
