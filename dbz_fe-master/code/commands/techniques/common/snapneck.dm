Command/Technique
	snapneck
		name = "snapneck"
		internal_name = "snapneck"
		format = "~snapneck; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = FINISHER;
		canFinish = TRUE;
		helpCategory = "Basic Combat"
		helpDescription = "Using your bare hands, break the neck of a fallen opponent."
		skillDatum = /atkDatum/snapneck 

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(target.unconscious){
					if(..(user,target)){
						return;
					}

					send("{B*{x {BYou wrap your hands around {x[target.raceColor(target.name)]{B's head...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] wraps [user.determineSex(1)] hands around [target.raceColor(target.name)]'s head...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R wraps [user.determineSex(1)] hands around your head...{x\n",target,TRUE)

				}else{
					send("You can't finish [target.raceColor(target.name)] right now!",user)
					return
				}

				new /atkDatum/snapneck(user,target,src,5)
			}
			else{
				syntax(user, getSyntax())
			}
		}