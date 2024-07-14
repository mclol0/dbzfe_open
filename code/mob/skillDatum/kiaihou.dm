atkDatum
	utility
		kiaihou
			name = "kiaihou"
			cost = 3
			cdTime = 10 SECONDS

			New(mob/caller,Command/c){
				if (caller && c) {
					user = caller
					command = c
					user._doEnergy(-getCost())
					game.addCooldown(user.name,command.internal_name, cdTime);
					go()
				}
			}

			go(){
				alaparser.parse(user, "yell HA!!!!!", list());

				for(var/mob/target in user.loc){
					if (!target:isStore) {
						var/direction = pick(NORTH,NORTHEAST,NORTHWEST,SOUTH,SOUTHEAST,SOUTHWEST,EAST,WEST)
						if(user.currpl > target.currpl && !target.isSafe()){
							send("{B*{x You eject [target.raceColor(target.name)] out of the room!", user)
							send("{W*{x [target.raceColor(target.name)] was ejected from the room by [user.raceColor(user.name)]!\n",a_oview_extra(0,user,target))
							var/oldloc = target.loc;
							target.Move(get_step(target,direction), direction, 0, 0, TRUE, FALSE)
							target.Move(get_step(target,direction), direction, 0, 0, TRUE, FALSE)
							if(target.loc != oldloc){
								send(buildMap(target,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),target);
								send("You were ejected out of the room by [user.raceColor(user.name)]!",target,TRUE);
							}
						}
					}
				}
			}