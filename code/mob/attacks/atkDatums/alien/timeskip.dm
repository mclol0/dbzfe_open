atkDatum/timeskip

	name = "timeskip";
	minDmg = 5
	maxDmg = 10
	cdTime = 80 SECONDS
	cost = 8
	costUsesDistance = TRUE
	stunChance = 75
	comboChance = 50

	defense = TRUE;

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			user._doEnergy(-getCost())
			..()
		}
	}

	go(){
		if(user.getArea() == target.getArea()){

			user.loc = target.loc;
			user.density = target.density;

			send("{B*{x You appear out of nowhere!",user)

			if(user.loc == target.loc && user.density == target.density){
				send("{R*{x [user.raceColor(user.name)] appears out of nowhere!",target)
				send("{W*{x [user.raceColor(user.name)] appears out of nowhere!",a_oview_extra(0,user,target))

				if (!target.unconscious && !target.stunned && prob(stunChance)){
					send("{B*{x {CYou knock [target.raceColor(target.name)]{C off guard!{x",user)
					send("{B*{x {C[user.raceColor(user.name)]{C knocks you off guard!{x",target)
					send("{B*{x {C[user.raceColor(user.name)]{C knocks [target.raceColor(target.name)]{C off guard!{x",a_oview_extra(0,user,target))
					stunned(target,user,comboChance=comboChance);
					game.addCooldown(user.name,command.internal_name, cdTime);
				}else{
					user.fCombat.doDamage(target,minDmg,maxDmg,"timeskip",command)
					game.addCooldown(user.name,command.internal_name, cdTime / 2);
				}
			}
		}
	}