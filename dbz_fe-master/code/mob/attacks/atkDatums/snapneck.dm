atkDatum/snapneck

	name = "snapneck";

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
			send("{B*{x You twist [target.raceColor(target.name)]'s neck, you hear a loud crack!",user)
			send("{R*{x [user.raceColor(user.name)] twists your neck and your body goes numb!",target)
			send("{W*{x [user.raceColor(user.name)] twists [target.raceColor(target.name)]'s neck, you hear a loud crack!",a_oview_extra(0,user,target))
		}

		if(isloc(user,target)) user.fCombat.doDamage(target,100,100,"snapneck",command)
	}