atkDatum/bio_assimilate

	name = "assimilate";

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			..()
		}
	}

	go(){
		if(!user.unconscious){
			send("{B*{x You absorb [target.raceColor(target.name)]!",user)
			send("{R*{x [user.raceColor(user.name)] absorbs you!",target)
			send("{W*{x [user.raceColor(user.name)] absorbs [target.raceColor(target.name)]!",a_oview_extra(0,user,target))

			if(!istype(user.loc.loc,/planet/arena)){
				var/calc = ret_percent((killPlayerPercent / 3),target.maxpl)

				user.gainPL(calc,target)
				target.gainPL(-calc,user)
			}
		}

		if(isloc(user,target)) user.fCombat.doDamage(target,95,100,"assimilate",command)
	}