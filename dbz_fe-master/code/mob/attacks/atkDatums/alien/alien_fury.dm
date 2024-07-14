atkDatum/alien_fury

	var/sendDir

	name = "fury";
	minDmg = 7
	maxDmg = 11
	minAttacks = 2
	maxAttacks = 5
	collisionMinDmg = 4
	collisionMaxDmg = 8
	throwMinDistance = 2
	throwMaxDistance = 5
	cdTime = 90 SECONDS
	cost = 5
	delayBetween = 0.50 SECONDS

	New(mob/caller,mob/objective,Command/c,gTime,direction){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			sendDir=direction;
			game.addCooldown(user,c.internal_name,cdTime);
			..()
		}
	}

	go(){
		for(var/i=maxAttacks,i>0,i--){
			if(user && target && target.stunned && !target.unconscious && !user.unconscious && user.loc == target.loc){
				user._doEnergy(-cost)
				send("{B*{x {BYou throw a [pick("punch","roundhouse","kick","sweep")] at{x [target.raceColor(target.name)]{B!{x\n",user)
				user.fCombat.doDamage(target,minDmg,maxDmg,"fury",NULL);

				if(i==1 && !target.isSafe()){
					var
						noCol = TRUE;
						oldLoc = NULL;

					send("{B*{x {BYour fury sends {x[target.raceColor(target.name)]{B flying [game.dir2text(sendDir)]!{x\n",user)
					send("{W*{x [user.raceColor(user.name)]'s fury sends [target.raceColor(target.name)] flying [game.dir2text(sendDir)]!\n",a_oview_extra(0,user,target))
					send("{R* {x[user.raceColor(user.name)]'s{R fury sends you flying [game.dir2text(sendDir)]!\n",target)

					var/attks = rand(throwMinDistance,throwMaxDistance);

					for(var/x=attks,x>0,x--){
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

			}else{
				break;
			}

			sleep(delayBetween);
		}
	}