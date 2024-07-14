Command/Technique
	self_destruct
		name = "selfdestruct"
		internal_name = "self destruct"
		format = "~selfdestruct; ?~searc(mob@melee_range_0)";
		syntax = "{cselfdestruct{x {c\[{x{Cmobile{x{c\]{x"
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		canFinish = TRUE

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){

				if(target.stunned){
					if(..(user,target)){
						return;
					}
					send("{B*{x {BYou wrap around {x[target.raceColor(target.name)]{B...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] wraps around [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]{R wraps around you...{x\n",target)

					user._doEnergy(-5)

					new /atkDatum/self_destruct(user,target,src,world.time)
				}else{
					send("They are not stunned!",user)
				}
			}
			else{
				syntax(user, "[syntax] {c\[{x{CRange: [user.calcMeleeRange(_maxDistance)] rooms{x{c\]{x",user)
			}
		}