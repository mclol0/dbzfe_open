fEAttk
	kienzan_projectile
		name = "kienzan"
		text = "{MO{x"
		display = "{MO{x"
		pColor = NULL;
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 30;
		speed = 4;
		minDmg = KIENZAN_MIN;
		maxDmg = KIENZAN_MAX;
		enPerTick = KIENZAN_EN_PERCH;
		cdTime = KIENZAN_COOLDOWN;
		delayBetween = 15
		maxBarrageLoad = 2
		dmgPerTick = KIENZAN_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			//Conc=TRUE
			chCount++
			user._doEnergy(-3,TRUE)
			go(targetRef,cRef)
		}

	kienzan
		name = "kienzan"
		text = "{MO{x"
		display = "{MO{x"
		pColor = NULL;
		isMultiProjectile = TRUE;
		maxRange = 30;
		speed = 4;
		minDmg = KIENZAN_MIN;
		maxDmg = KIENZAN_MAX;
		enPerTick = KIENZAN_EN_PERCH;
		cdTime = KIENZAN_COOLDOWN;
		delayBetween = 15
		maxBarrageLoad = 2
		dmgPerTick = KIENZAN_DAMAGE_PERCH;

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
						new /fEAttk/kienzan_projectile(mobRef,targetRef,cRef)
						if(i>=maxBarrageLoad){ break; }
						delayBetween = (world.time + 10);
					}
					sleep(world.tick_lag)
				}


				send("Your kienzan dissipates!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			mobRef = user
			targetRef = target
			cRef = c
			//Conc=TRUE
			maxBarrageLoad = load
			fire_dd()
		}

		Del(){
			..()
		}