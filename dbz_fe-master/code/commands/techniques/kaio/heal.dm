Command/Technique
	kaio_heal
		name = "heal"
		internal_name = "kaio heal"
		format = "~heal; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = UTILITY;

		command(mob/user, mob/target=user) {

			if(target && a_get_dist(user,target) <= _maxDistance){
				if(..(user,target,or=TRUE)){
					return;
				}

				if(isnpc(target) && user != target){
					send("You can only heal players!",user);
					return FALSE;
				}

				if(target!=user){
					var/hand = pick("left","right");
					send("{B*{x {BYou place your [hand] hand on {x[target.raceColor(target.name)]{B's chest...{x\n",user)
					send("{W*{x [user.raceColor(user.name)] places [user.determineSex(1)] [hand] hand on [target.raceColor(target.name)]'s chest...\n",a_oview_extra(0,user,target))
					send("{G* {x[user.raceColor(user.name)]{C places [user.determineSex(1)] [hand] hand on your chest...{x\n",target,TRUE)
					new /atkDatum/kaio_heal(user,target,src,world.time)
				}else{
					new /atkDatum/kaio_heal(user,target,src,world.time)
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}