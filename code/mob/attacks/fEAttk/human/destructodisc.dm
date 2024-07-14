fEAttk
	destructodisc_projectile
		name = "destructodisc"
		text = "{YO{x"
		display = "{YO{x"
		pColor = NULL;
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 4;
		minDmg = DESTRUCTODISC_MIN;
		maxDmg = DESTRUCTODISC_MAX;
		enPerTick = DESTRUCTODISC_EN_PERCH;
		cdTime = DESTRUCTODISC_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 4 
		maxBarrageLoad = 4
		dmgPerTick = DESTRUCTODISC_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			//Conc=TRUE
			chCount++
			user._doEnergy(-4,TRUE)
			go(targetRef,cRef)
		}

	destructodisc
		name = "destructodisc"
		text = "{YO{x"
		display = "{YO{x"
		pColor = NULL;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 4;
		minDmg = DESTRUCTODISC_MIN;
		maxDmg = DESTRUCTODISC_MAX;
		enPerTick = DESTRUCTODISC_EN_PERCH;
		cdTime = DESTRUCTODISC_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 4
		maxBarrageLoad = 4
		dmgPerTick = DESTRUCTODISC_DAMAGE_PERCH;

		proc
			fire_dd(){
				set waitfor=FALSE

				Conc=TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 20);

				while(src && mobRef && targetRef && Conc){
					if(world.time>=delayBetween){
						i++
						new /fEAttk/destructodisc_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){ break; }
						delayBetween = (world.time + 15);
					}
					sleep(world.tick_lag)
				}


				send("Your destructo disc dissipates!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			mobRef = user
			targetRef = target
			cRef = c
			//Conc=TRUE
			currentBarrageLoad = load
			fire_dd()
		}

		Del(){
			..()
		}