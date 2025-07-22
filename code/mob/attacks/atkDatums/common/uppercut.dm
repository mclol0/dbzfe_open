atkDatum/uppercut

	name = "uppercut";
	minDmg = 6
	maxDmg = 8
	stunChance = 15
	comboChance = 50
	cost = 2

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
		if(!user.unconscious){
			send("{B*{x You try to [name] [target.raceColor(target.name)]!",user)
			send("{R*{x [user.raceColor(user.name)] tries to [name] you!",target)
			send("{W*{x [user.raceColor(user.name)] tries to [name] [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
		}

		if(user.fCombat.doDamage(target,minDmg,maxDmg,"uppercut",command)){
			if(target.density && !target.unconscious && !target.insideBuilding){
				send("{B*{x Your [name] sent [target.raceColor(target.name)] flying into the sky!",user);
				send("{R*{x [user.raceColor(user.name)]'s [name] sent you flying into the sky!",target);
				send("{W*{x [user.raceColor(user.name)]'s [name] sent [target.raceColor(target.name)] flying into the sky!",a_oview_extra(0,user,target));

				if(isplayer(target)) target.fly();

				target.density = FALSE;
			}

			if(!target.stunned && decimal_prob(stunChance)) { stunned(target,user,comboChance=comboChance); }
		}
	}