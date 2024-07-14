atkDatum/hellfirelance

	name = "hellfirelance";
	minDmg = 17
	maxDmg = 17
	cost = 4
	throwMinDistance = 3
	throwMaxDistance = 5
	collisionMinDmg = 11
	collisionMaxDmg = 17

	New(mob/caller,mob/objective,Command/c,gTime){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			user._doEnergy(-getCost(),TRUE)
			..()
		}
	}

	go(){
		if(!user.unconscious){
			send("{B*{x You try to hit [target.raceColor(target.name)] with a [name]!",user)
			send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
			send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
		}
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"hellfirelance",command)){
			var/sendDir = game.dirRev(user.dir);

			if(game.dir2text_map(sendDir) in target.Exits(TRUE)){
				var
					noCol = TRUE;
					oldLoc = NULL;

				send("{B*{x Your [name] sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!",user)
				send("{W*{x [user.raceColor(user.name)] [name] sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!",a_oview_extra(0,user,target))
				send("{R*{x [user.raceColor(user.name)] [name] sends you flying [game.dir2text(sendDir)]!",target)

				if(!target.isSafe()){
					for(var/i=rand(throwMinDistance,throwMaxDistance),i>0,i--){
						oldLoc=target.loc;
						target.Move(get_step(target,sendDir), sendDir, 0, 0, TRUE, FALSE)
						if(oldLoc==target.loc){
							send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target);
							noCol = FALSE;
							user.fCombat.doDamage(target,collisionMinDmg,collisionMaxDmg,"collision damage",command)
							break;
						} else { continue }
					}

					if(noCol){ send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target); }
				}
			}
		}
	}
