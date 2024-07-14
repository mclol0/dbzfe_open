atkDatum/lure

	name = "lure";
	minDmg = 4
	maxDmg = 8
	cdTime = 15 SECONDS
	cost = 2
	costUsesDistance = TRUE

	var
		direction

	New(mob/caller,mob/objective,Command/c,gTime,hand){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			direction = hand
			user._doEnergy(-getCost())
			..()
		}
	}

	go(){
		if(!user.unconscious){
			send("{B*{x You whip [target.raceColor(target.name)]!",user)
			send("{R*{x [user.raceColor(user.name)] whips you!",target)
			send("{W*{x [user.raceColor(user.name)] whips [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
		}
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"whip",command)){
			if(!target.isSafe()){ target.loc = user.loc; }
			send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target,TRUE);
			alaparser.parse(user, "yell GET OVER HERE!", list());
		}

		game.addCooldown(user.name,command.internal_name,cdTime);
	}