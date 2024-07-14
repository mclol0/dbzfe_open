atkDatum/tail_whip

	name = "tailwhip";
	minDmg = 10
	maxDmg = 15
	throwChance = 35
	throwMinDistance = 2
	throwMaxDistance = 5
	collisionMinDmg = 5
	collisionMaxDmg = 10
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
			send("{B*{x You try to hit [target.raceColor(target.name)] with a [name]!",user)
			send("{R*{x [user.raceColor(user.name)] tries to hit you with a [name]!",target)
			send("{W*{x [user.raceColor(user.name)] tries to hit [target.raceColor(target.name)] with a [name]!",a_oview_extra(0,user,target))
		}
		if(user.fCombat.doDamage(target,minDmg,maxDmg,"tailwhip",command) && !target.unconscious && !target.stunned && prob(throwChance)){
			var/sendDir = game.dirRev(user.dir);

			if(game.dir2text_map(sendDir) in target.Exits(TRUE)){
				var
					noCol = TRUE;
					oldLoc = NULL;

				send("{B*{x Your tailwhip sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!",user)
				send("{W*{x [user.raceColor(user.name)] tailwhip sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!",a_oview_extra(0,user,target))
				send("{R*{x [user.raceColor(user.name)] tailwhip sends you flying [game.dir2text(sendDir)]!",target)

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