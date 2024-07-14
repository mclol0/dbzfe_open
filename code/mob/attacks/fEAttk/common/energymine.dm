fEAttk
	energyMine
		display = "{M@{x"
		text = "<font color=magenta>@</font>"
		pColor = "{M"
		minDmg = 12
		maxDmg = 20
		cdTime = 30 SECONDS
		enPerTick = 10

		mineLifeTime = 1.5 MINUTES
		mineDeathTime = 0

		proc
			life(){
				set waitfor = FALSE;

				while(src && mobRef){
					if(world.time >= mineDeathTime){ break; }

					for(var/mob/m in loc){
						if(mobRef.fCombat.hostileTargets.Find(m)){
							send("{R*BOOM*{x {BYour energy mine explodes in {x[m.raceColor(m.name)]{B's face!{x",mobRef)
							send("{R*BOOM*{x {RYou step onto {x[mobRef.raceColor(mobRef.name)]{R's energy mine!{x",m)
							send("{W*{x {R*BOOM*{x [m.raceColor(m.name)] steps onto [mobRef.raceColor(mobRef.name)]'s energy mine!",a_oview_extra(0,mobRef,m))
							mobRef.fCombat.doDamage(m,minDmg,maxDmg,"energy mine",cRef)
							mineDeathTime = 0;
							break;
						}
					}

					sleep(world.tick_lag);
				}

				del(src);
			}

		New(mob/caller, Command/c){
			if (caller && c) {
				mobRef = caller;
				cRef = c;

				mineDeathTime = (world.time + mineLifeTime)
				game.addCooldown(mobRef.name,c.internal_name,cdTime)
				mobRef._doEnergy(-enPerTick,TRUE)

				loc=locate(mobRef.x,mobRef.y,mobRef.z);

				life();
			}
		}