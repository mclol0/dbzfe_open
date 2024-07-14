fEAttk
	consecrate
		display = "{C@{x"
		text = "<font color=cyan>@</font>"
		pColor = "{C"
		minDmg = 0
		maxDmg = 0
		cdTime = 180 SECONDS
		enPerTick = 0

		healLifeTime = 65 SECONDS
		healDeathTime = 0

		proc
			life(){
				set waitfor = FALSE;

				while(src && mobRef){
					if(world.time >= healDeathTime){ break; }

					for(var/mob/m in loc){
						if(!isnpc(m)) {
							if(mobRef.fCombat.hostileTargets.Find(m)) {
								// Do Nothing. They are the ENEMY!
							} else {
								if(m.unconscious) {
									m.regainConscious(TRUE);
								}

								if(!m.unconscious) {
									var/healAmount = ret_percent(rand_decimal(4,6),m.getMaxPL());
									var/stamAmount = ret_percent(rand_decimal(6,8),m.getMaxEN()());
									m._doEnergy(stamAmount);
									m._doDamage(healAmount);
									send("{CThe consecrated ground around you mends your wounds...{x", m);
								}
							}
						}
					}

					sleep(world.tick_lag + 10 SECONDS);
				}

				del(src);
			}

		New(mob/caller, Command/c){
			if (caller && c) {
				mobRef = caller;
				cRef = c;

				healDeathTime = (world.time + healLifeTime)
				game.addCooldown(mobRef.name,c.internal_name,cdTime)
				//mobRef._doEnergy(-enPerTick,TRUE)

				loc=locate(mobRef.x,mobRef.y,mobRef.z);
				new /obj/item/consecrated_ground(locate(mobRef.x,mobRef.y,mobRef.z));

				life();
			}
		}
