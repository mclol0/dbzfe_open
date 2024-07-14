mob/proc
	get_ground_name(){
		if(loc:tType == WATER){
			return "water"
		}else{
			return "ground"
		}
	}

atkDatum/hammer

	name = "hammer";
	minDmg = 6
	maxDmg = 8
	collisionMinDmg = 4
	collisionMaxDmg = 7
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

		if(user.fCombat.doDamage(target,minDmg,maxDmg,"hammer",command) && !target.density){

			send("{B*{x Your [name] sent [target.raceColor(target.name)] flying into the [target.get_ground_name()]!",user);
			send("{R*{x [user.raceColor(user.name)]'s [name] sent you flying into the [target.get_ground_name()]!",target);
			send("{W*{x [user.raceColor(user.name)]'s [name] sent [target.raceColor(target.name)] flying into the [target.get_ground_name()]!",a_oview_extra(0,user,target));

			target.density = TRUE;

			user.fCombat.doDamage(target,collisionMinDmg,collisionMaxDmg,"collision damage",command)
		}
	}