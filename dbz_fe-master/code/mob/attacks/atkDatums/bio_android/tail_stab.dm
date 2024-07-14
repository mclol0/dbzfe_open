atkDatum/tail_stab

	name = "tailstab";
	minDmg = 9
	maxDmg = 13
	cost = 4
	bleedChance = 60
	costUsesDistance = TRUE

	var
		direction

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
			var/area = pick ("left leg", "right leg","left arm","right arm","stomach","face","chest");

			send("{B*{x You thrust your tail towards [target.raceColor(target.name)]'s [area]!",user)
			send("{R*{x [user.raceColor(user.name)] thrusts their tail towards your [area]!",target)
			send("{W*{x [user.raceColor(user.name)] thrusts their tail towards [target.raceColor(target.name)]'s [area]!",a_oview_extra(0,user,target))
		}
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"tailstab",command) && !target.unconscious && prob(bleedChance)){
			target._doEnergy(-2);
			target.bleedDamage(user);
		}
	}