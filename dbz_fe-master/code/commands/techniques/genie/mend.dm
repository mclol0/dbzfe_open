Command/Technique
	mend
		name = "mend"
		internal_name = "genie heal"
		format = "~mend; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Focus your energy and restore another player's stamina."
		skillDatum = /atkDatum/utility/mend

		command(mob/user, mob/target) {

			if(target && a_get_dist(user,target) <= _maxDistance){
				if(..(user,target,or=TRUE)){
					return;
				}

				if(isnpc(target)){
					send("You can only mend players!",user);
					return FALSE;
				}

				send("{B*{x {BYou focus on {x[target.raceColor(target.name)]{B and begin to concentrate...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] focuses [user.determineSex(1)] energy on [target.raceColor(target.name)] and begins to concentrate...\n",a_oview_extra(0,user,target))
				send("{G* {x[user.raceColor(user.name)]{C focuses [user.determineSex(1)] energy on you and begins to concentrate...{x\n",target,TRUE)

				var/healStack = locGenieHeal(target);

				if(!healStack){
					new /atkDatum/genie_heal(user,target,src,getAttackDelay(src, user.fCombat, target))
				}else{
					healStack:maxRestoreStacks+=5; // increment heal tick amount
					game.addCooldown(user.name,internal_name,120 SECONDS);
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}