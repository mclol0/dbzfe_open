Command/Technique
	genie_assimilate
		name = "assimilate"
		internal_name = "genie assimilate"
		format = "~assimilate; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = FINISHER;
		canFinish = TRUE;

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(target.unconscious){
					if(..(user,target)){
						return;
					}

					send("{B*{x {BYou morph into a giant blob and engulf {x[target.raceColor(target.name)]'s{x {Bunconscious body...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] morphs into a giant blob and engulfs [target.raceColor(target.name)]'s unconscious body...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R morphs into a giant blob and engulfs you...{x\n",target,TRUE)

				}else{
					send("You can't finish [target.raceColor(target.name)] right now!",user)
					return
				}

				new /atkDatum/genie_assimilate(user,target,src,20)
			}
			else{
				syntax(user, getSyntax())
			}
		}