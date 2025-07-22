atkDatum/zanzoken

	name = "zanzoken";
	stunChance = 7.5
	comboChance = 40
	cost = 4
	costUsesDistance = TRUE

	defense = TRUE;

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			if(user.loc == target.loc && user.density == target.density){
				user._doEnergy(-getCost())
			} else {
				user._doEnergy(-getCost()/4)
			}
			..()
		}
	}

	go(){
		if(user.getArea() == target.getArea()){
			send("{B*{x You appear out of nowhere!",user)
			send("{R*{x [user.raceColor(user.name)] appears out of nowhere!",target)

			if(user.loc == target.loc && user.density == target.density){
				send("{W*{x [user.raceColor(user.name)] appears out of nowhere!",a_oview_extra(0,user,target))
				if (!target.unconscious && !target.stunned && decimal_prob(stunChance)){
					send("{B*{x {CYou knock [target.raceColor(target.name)]{C off guard!{x",user)
					send("{B*{x {C[user.raceColor(user.name)]{C knocks you off guard!{x",target)
					send("{B*{x {C[user.raceColor(user.name)]{C knocks [target.raceColor(target.name)]{C off guard!{x",a_oview_extra(0,user,target))
					stunned(target,user,comboChance=comboChance);
				}
			} else {
				user.density=target.density;
				user.loc=target.loc;
				send("{W*{x [user.raceColor(user.name)] appears out of nowhere!",a_oview_extra(0,user,target))
				if(!target.unconscious && !target.stunned && decimal_prob(stunChance)){
					send("{B*{x {CYou knock [target.raceColor(target.name)]{C off guard!{x",user)
					send("{B*{x {C[user.raceColor(user.name)]{C knocks you off guard!{x",target)
					send("{B*{x {C[user.raceColor(user.name)]{C knocks [target.raceColor(target.name)]{C off guard!{x",a_oview_extra(0,user,target))
					stunned(target,user,comboChance=comboChance / 2);
				}
			}
		}
	}