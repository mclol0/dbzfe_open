atkDatum/aura_slide

	name = "aura slide";
	minDmg = 5
	maxDmg = 6
	cost = 3
	bleedChance = 25
	maxAttacks = 3
	delayBetween = 0.75 SECONDS
	costUsesDistance = TRUE

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
		for(var/i=0;i<maxAttacks;i++){
			if(!user || !target || user.unconscious || user.stunned){ break; }

			if(!user.unconscious){
				send("{B*{x You try to hit [target.raceColor(target.name)] with a [name]!",user)
				send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
				send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
			}
			if(user.fCombat.doDamage(target,minDmg,maxDmg,"aura slide",command) && !target.unconscious && !target.stunned && decimal_prob(bleedChance)) {
				target.bleedDamage(user);
			}

			if(i < maxAttacks - 1){
				send("{B*{x {BYou prepare to thrust another attack...{x\n",user)
				send("{W*{x [user.raceColor(user.name)] prepares to thrust another attack...\n",a_oview_extra(0,user,target))
				send("{R* {R [user.raceColor(user.name)]{R prepares to thrust another attack...{x [target.defenseTips(src)]\n",target)
			}

			user._doEnergy(-getCost())

			sleep(delayBetween);
		}
	}