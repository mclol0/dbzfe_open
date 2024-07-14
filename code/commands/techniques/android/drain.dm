Command/Technique
	drain
		name = "drain"
		internal_name = "drain"
		format = "~drain; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		canFinish = TRUE;
		needsSTUN = TRUE;
		helpCategory = "Advanced Combat"
		helpDescription = "Steal your opponent's life force to recover yourself."
		skillDatum = /atkDatum/drain

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){

				if(target.stunned){
					if(..(user,target)){
						return;
					}
					send("{B*{x {BYou grab {x[target.raceColor(target.name)]{B by the throat...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] grabs [target.raceColor(target.name)] by the throat...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R grabs on to your throat...{x\n",target)

					new /atkDatum/drain(user,target,src,world.time)
				}else{
					send("They are not stunned!",user)
				}
			}
			else{
				send(user, getSyntax())
			}
		}