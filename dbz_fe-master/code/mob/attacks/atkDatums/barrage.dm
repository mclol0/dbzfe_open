atkDatum/barrage

	name = "barrage";
	minDmg = 5
	maxDmg = 9
	minAttacks = 3
	maxAttacks = 7
	cdTime = 15 SECONDS
	cost = 1
	delayBetween = 2 SECONDS
	costUsesDistance = TRUE

	var
		attackType
		attackCount

	New(mob/caller,mob/objective,Command/c,gTime,aType){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			attackType = aType
			attackCount = rand(minAttacks, maxAttacks)
			var/costMod = aType == PUNCH_LEFT || aType == PUNCH_RIGHT ? 0 : 1
			user._doEnergy(-getCost() + costMod)
			game.addCooldown(user.name,c.internal_name,cdTime);
			..()
		}
	}

	go(){
		for(var/i=attackCount,i>0,i--){
			if(user.atkDat:name == "barrage" && user && target && !user.stunned && !user.sleeping && !user.resting && !user.unconscious && !target.unconscious && user.loc == target.loc){
				if (attackType == PUNCH_LEFT || attackType == PUNCH_RIGHT) {
					var/punchMsg = attackType == PUNCH_LEFT ? "left-handed" : "right-handed"
					send("{B*{x You throw a [punchMsg] punch at [target.raceColor(target.name)]!",user)
					send("{R*{x [user.raceColor(user.name)] throws a [punchMsg] punch at you!",target)
					send("{W*{x [user.raceColor(user.name)] throws a [punchMsg] punch at [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
					user.fCombat.doDamage(target,minDmg,maxDmg-1,"punch",command)
				} else if (attackType == KICK_LEFT || attackType == KICK_RIGHT) {
					var/kickMsg = attackType == KICK_LEFT ? "left-legged" : "right-legged"
					send("{B*{x You launch a [kickMsg] kick at [target.raceColor(target.name)]!",user)
					send("{R*{x [user.raceColor(user.name)] launches a [kickMsg] kick at you!",target)
					send("{W*{x [user.raceColor(user.name)] launches a [kickMsg] kick at [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
					user.fCombat.doDamage(target,minDmg + 1,maxDmg,"kick",command)
				}
				sleep(0.50 SECONDS)
				attackType = rand(PUNCH_LEFT,KICK_RIGHT);
				if(i<=1) {
					send("{xYou cease your melee barrage.{x\n",user)
					break;
				}
				if(user.atkDat:name == "barrage" && user && target && !user.stunned && !user.sleeping && !user.resting && !user.unconscious && !target.unconscious && user.loc == target.loc){
					var/costMod = attackType == PUNCH_LEFT || attackType == PUNCH_RIGHT ? 0 : 1
					user._doEnergy(-getCost() + costMod)

					switch(attackType){
						if(PUNCH_LEFT){
							command.defenses = list(PARRY_HIGH,DODGE_LEFT,BARRIER)
							send("{B*{x {BYou continue your barrage by retracting your left arm...{x\n",user)
							send("{W*{x [user.raceColor(user.name)] continues [user.determineSex(1)] barrage by retracting [user.determineSex(1)] left arm...\n",a_oview_extra(0,user,target))
							send("{R*{x [user.raceColor(user.name)]{R continues [user.determineSex(1)] barrage by retracting [user.determineSex(1)] left arm...{x [target.defenseTips(command)]\n",target)
						}
						if(PUNCH_RIGHT){
							command.defenses = list(PARRY_HIGH,DODGE_RIGHT,BARRIER)
							send("{B*{x {BYou continue your barrage by retracting your right arm...{x\n",user)
							send("{W*{x [user.raceColor(user.name)] continues [user.determineSex(1)] barrage by retracting [user.determineSex(1)] right arm...\n",a_oview_extra(0,user,target))
							send("{R*{x [user.raceColor(user.name)]{R continues [user.determineSex(1)] barrage by retracting [user.determineSex(1)] right arm...{x [target.defenseTips(command)]\n",target)
						}
						if(KICK_LEFT){
							command.defenses = list(PARRY_LOW,DODGE_LEFT,BARRIER)
							send("{B*{x {BYou continue your barrage by curling your left leg...{x\n",user)
							send("{W*{x [user.raceColor(user.name)] continues [user.determineSex(1)] barrage by curling [user.determineSex(1)] left leg...\n",a_oview_extra(0,user,target))
							send("{R*{x [user.raceColor(user.name)]{R continues [user.determineSex(1)] barrage by curling [user.determineSex(1)] left leg...{x [target.defenseTips(command)]\n",target)
						}
						if(KICK_RIGHT){
							command.defenses = list(PARRY_LOW,DODGE_RIGHT,BARRIER)
							send("{B*{x {BYou continue your barrage by curling your right leg...{x\n",user)
							send("{W*{x [user.raceColor(user.name)] continues [user.determineSex(1)] barrage by curling [user.determineSex(1)] right leg...\n",a_oview_extra(0,user,target))
							send("{R*{x [user.raceColor(user.name)]{R continues [user.determineSex(1)] barrage by curling [user.determineSex(1)] right leg...{x [target.defenseTips(command)]\n",target)
						}
					}

					sleep(delayBetween)
				} else {
					send("{xYou cease your melee barrage.{x\n",user)
					break;
				}
			} else {
				send("{xYou cease your melee barrage.{x\n",user)
				break;
			}
		}
	}