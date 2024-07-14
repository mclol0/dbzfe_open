fEAttk
	divinecannon
		name = "divinecannon"
		text = "{Y^{x"
		display = "{Y^{x"
		pColor = NULL;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 5;
		minDmg = DIVINECANNON_MIN;
		maxDmg = DIVINECANNON_MAX;
		enPerTick = DIVINECANNON_EN_PERCH;
		cdTime = DIVINECANNON_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 4
		maxBarrageLoad = 4
		dmgPerTick = DIVINECANNON_DAMAGE_PERCH;

		proc
			fire_es(){
				set waitfor=FALSE

				Conc=TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 20);

				while(src && mobRef && targetRef && Conc){
					if(world.time>=delayBetween){
						i++
						new /fEAttk/divinecannon_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){ break; }
						delayBetween = (world.time + 15);
					}
					sleep(world.tick_lag)
				}


				send("Your divine cannon fizzles out.",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			currentBarrageLoad = load
			Conc=TRUE
			fire_es()
		}

		Del(){
			..()
		}

	divinecannon_projectile
		name = "divinecannon"
		text = "{Y^{x"
		display = "{Y^{x"
		pColor = NULL;
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 5;
		minDmg = DIVINECANNON_MIN;
		maxDmg = DIVINECANNON_MAX;
		enPerTick = DIVINECANNON_EN_PERCH;
		cdTime = DIVINECANNON_COOLDOWN;
		delayBetween = 20
		currentBarrageLoad = 5
		maxBarrageLoad = 5
		dmgPerTick = DIVINECANNON_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			chCount++
			user._doEnergy(-2,TRUE)
			user._doDamage(ret_percent(-1.50,user.currpl))
			go(targetRef,cRef)
		}

