Command/Technique
	haunt
		name = "haunt"
		internal_name = "haunt"
		format = "~haunt; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = ENERGY;
		canFinish = FALSE;
		needsSTUN = TRUE;
		helpCategory = "Advanced Combat"
		helpDescription = "Steal your opponent's life force to recover yourself."
		skillDatum = /atkDatum/haunt

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){

				if(target.stunned){
					if(..(user,target)){
						return;
					}
					send("{m*{x {BYou place your hand on {x[target.raceColor(target.name)]{B's forehead...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] grabs [target.raceColor(target.name)] by the forhead..\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R grabs on to your forehead...{x\n",target)

					new /atkDatum/haunt(user,target,src,world.time)
				}else{
					send("They are not stunned!",user)
				}
			}
			else{
				send(user, getSyntax())
			}
		}
