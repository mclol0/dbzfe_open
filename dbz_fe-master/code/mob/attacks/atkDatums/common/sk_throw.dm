atkDatum/sk_throw

	name = "throw";
	minDmg = 5
	maxDmg = 6
	throwMinDistance = 3
	throwMaxDistance = 6
	collisionMinDmg = 5
	collisionMaxDmg = 10
	cdTime = 5 SECONDS
	cost = 3
	var/sendDir

	New(mob/caller,mob/objective,Command/c,gTime,direction){
		if (caller && objective) {
			user = caller
			user.atkDat = src
			target = objective
			AID = ++user.aID
			goTime = gTime
			command = c
			sendDir=game.text2Dir(direction);
			game.addCooldown(user.name, c.internal_name, cdTime);
			user._doEnergy(-getCost())
			..()
		}
	}

	go(){
		if(game.map_dir_text[sendDir] in target.Exits(TRUE)){
			var
				noCol = TRUE;
				oldLoc = NULL;

			send("{B*{x {BYou throw {x[target.raceColor(target.name)]{B [game.dir2text(sendDir)]!{x\n",user)
			send("{W*{x [user.raceColor(user.name)] throws [target.raceColor(target.name)] [game.dir2text(sendDir)]!\n",a_oview_extra(0,user,target))

			user.fCombat.doDamage(target,minDmg,maxDmg,"throw",command)

			if(!target.isSafe()){
				for(var/i=rand(throwMinDistance,throwMaxDistance),i>0,i--){
					oldLoc=target.loc;
					if("[game.dir2text(sendDir)]" in target.Exits(TRUE)){ target.Move(get_step(target,sendDir), sendDir, 0, 0, TRUE, FALSE) }
					if(oldLoc==target.loc){
						send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target);
						noCol = FALSE;
						user.fCombat.doDamage(target,collisionMinDmg,collisionMaxDmg,"collision damage",command)
						break;
					} else { continue }
				}

				if(noCol){ send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target); }
			}

			send("{R* {x[user.raceColor(user.name)]{R throws you [game.dir2text(sendDir)]!{x\n",target)
		}
	}