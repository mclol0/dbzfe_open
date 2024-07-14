Command/Technique
	purify
		name = "purify"
		internal_name = "purify"
		format = "~purify; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = FINISHER;
		canFinish = TRUE;
		helpCategory = "Finishers"
		helpDescription = " purify and cleanse your enemy, leeching its very life essense and power."
		skillDatum = /atkDatum/purify

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(target.unconscious){
					if(..(user,target)){
						return;
					}

					var/area = pick("FOREHEAD","CHEST");

					send("{B*{x {BYou pierce your hand through [target.raceColor(target.name)]{B's{x {m[pick(area)]{B...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] pierces their hand through [target.raceColor(target.name)]'s {m[area]{W...{x\n",a_oview_extra(0,user,target))
					send("{R*{x [user.raceColor(user.name)] {Rpierces their hand into your {r[area]{R...{x\n",target,TRUE)

				}else{
					send("You can't finish [target.raceColor(target.name)] right now!",user)
					return
				}

				new /atkDatum/purify(user,target,src,20)
			}
			else{
				syntax(user, getSyntax())
			}
		}
