Command/Technique
	namek_fuse
		name = "fuse"
		internal_name = "namek fuse"
		format = "~fuse; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 1
		_maxDistance = 0;
		tType = FINISHER;
		canFinish = TRUE;
		helpCategory = "Finishers"
		helpDescription = "Namek's unique capability. Place your hand on a defeated namekian and fuse together to become stronger."
		skillDatum = /atkDatum/namek_fuse

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) == 0){
				if(target.unconscious){
					if(..(user,target)){
						return;
					}

					if(target.race != NAMEK){
						send("You can only fuse with other Namekian's!",user);

						return;
					}

					var/hand = pick("left","right");

					send("{B*{x {BYou place your [hand] hand on {x[target.raceColor(target.name)]{B's chest...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] places [user.determineSex(1)] [hand] hand on [target.raceColor(target.name)]'s chest...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R places [user.determineSex(1)] [hand] hand on your chest...{x\n",target,TRUE)

				}else{
					send("You can't finish [target.raceColor(target.name)] right now!",user)
					return
				}

				new /atkDatum/namek_fuse(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}