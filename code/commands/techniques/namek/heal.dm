Command/Technique
	namek_heal
		name = "heal"
		internal_name = "namek heal"
		format = "~heal; ?~searc(mob@melee_range_0)";
		priority = 2
		_maxDistance = 2;
		tType = UTILITY;

		command(mob/user, mob/target) {

			if(target && a_get_dist(user,target) <= _maxDistance){
				if(..(user,target,or=TRUE)){
					return;
				}

				if(isnpc(target)){
					send("You can only heal players!",user);
					return FALSE;
				}

				var/hand = pick("left","right");

				send("{B*{x {BYou place your [hand] hand on {x[target.raceColor(target.name)]{B's chest...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] places [user.determineSex(1)] [hand] hand on [target.raceColor(target.name)]'s chest...\n",a_oview_extra(0,user,target))
				send("{G* {x[user.raceColor(user.name)]{C places [user.determineSex(1)] [hand] hand on your chest...{x\n",target,TRUE)

				var/healStack = locNamekHeal(target);

				if(!healStack){
					new /atkDatum/namek_heal(user,target,src,getAttackDelay(src, user.fCombat, target))
				}else{
					user._doEnergy(-10);
					healStack:maxRestoreStacks+=5; // increment heal tick amount
					game.addCooldown(user.name,internal_name,120 SECONDS);
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}