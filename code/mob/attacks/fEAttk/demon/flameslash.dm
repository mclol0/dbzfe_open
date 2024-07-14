fEAttk
	flameslash
		name = "flameslash"
		text = "{R~{x"
		display = "{R~{x"
		pColor = NULL;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 2;
		minDmg = FLAMESLASH_MIN;
		maxDmg = FLAMESLASH_MAX;
		enPerTick = FLAMESLASH_EN_PERCH;
		cdTime = FLAMESLASH_COOLDOWN;
		delayBetween = 7
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		dmgPerTick = FLAMESLASH_DAMAGE_PERCH;

		proc
			fire_fs(){
				set waitfor=FALSE

				Conc=TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 20);

				while(src && mobRef && targetRef && Conc){
					if(world.time>=delayBetween){
						i++
						new /fEAttk/flame_slash_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){ break; }
						delayBetween = (world.time + 7);
					}
					sleep(world.tick_lag)
				}


				send("Your flame slash dissipates!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			currentBarrageLoad = load
			Conc=TRUE
			fire_fs()
		}

		Del(){
			..()
		}

	flame_slash_projectile
		name = "flameslash"
		text = "{R~{x"
		display = "{R~{x"
		pColor = NULL;
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 2;
		minDmg = FLAMESLASH_MIN;
		maxDmg = FLAMESLASH_MAX;
		enPerTick = FLAMESLASH_EN_PERCH;
		cdTime = FLAMESLASH_COOLDOWN;
		delayBetween = 7
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		dmgPerTick = FLAMESLASH_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			chCount++
			user._doDamage(ret_percent(-1.50,user.currpl))
			go(targetRef,cRef)
		}