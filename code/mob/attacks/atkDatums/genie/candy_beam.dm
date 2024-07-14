atkDatum/candy_beam

	name = "candy beam";

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
			send("{B*{x You transform [target.raceColor(target.name)] into a piece of {Mcandy{x!",user)
			send("{R*{x [user.raceColor(user.name)] transforms you into a piece of {Mcandy{x!",target)
			send("{W*{x [user.raceColor(user.name)] transforms [target.raceColor(target.name)] into a piece of {Mcandy{x!",a_oview_extra(0,user,target))
		}

		if(isplayer(user) && user:canGain(target,FALSE,10)){ new /obj/item/CANDY(locate(target.x,target.y,target.z)); }

		if(isloc(user,target) && isinstance(user,target)) user.fCombat.doDamage(target,95,100,"candy beam",command)
	}