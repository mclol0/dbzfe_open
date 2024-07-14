fEAttk
	burning_attack
		name = "burning attack"
		text = "{yo{x"
		display = "{yo{x"
		pColor = "{Y"
		isMultiProjectile = TRUE;
		isCharge = FALSE;
		maxRange = 20;
		speed = 4;
		minDmg = BURNING_ATTACK_MIN;
		maxDmg = BURNING_ATTACK_MAX;
		enPerTick = BURNING_ATTACK_EN_PERCH;
		delayBetween = 5
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		cdTime = BURNING_ATTACK_COOLDOWN;
		dmgPerTick = BURNING_ATTACK_DAMAGE_PERCH;

		proc
			fire_ba(){
				set waitfor=FALSE

				Conc=TRUE;

				var/
					i = 0;
					delayBetween = (world.time + 30);

				while(src && mobRef && targetRef && Conc){
					if(world.time>=delayBetween){
						i++
						new /fEAttk/burning_attack_projectile(mobRef,targetRef,cRef)
						if(i>=currentBarrageLoad){ break; }
						delayBetween = (world.time + 3);
					}
					sleep(world.tick_lag)
				}


				send("Your movements falter!",mobRef)
				clean()
			}

		New(mob/user, mob/target, Command/c, load){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			currentBarrageLoad = load
			Conc=TRUE
			fire_ba()
		}

		Del(){
			..()
		}


	burning_attack_projectile
		name = "burning attack"
		text = "{yo{x"
		display = "{yo{x"
		pColor = "{Y"
		isCharge=FALSE;
		isMultiProjectile = TRUE;
		maxRange = 20;
		speed = 2;
		minDmg = BURNING_ATTACK_MIN;
		maxDmg = BURNING_ATTACK_MAX;
		enPerTick = BURNING_ATTACK_EN_PERCH;
		cdTime = BURNING_ATTACK_COOLDOWN;
		delayBetween = 5
		currentBarrageLoad = 3
		maxBarrageLoad = 3
		dmgPerTick = BURNING_ATTACK_DAMAGE_PERCH;
		MULTI_PROJECTILE = TRUE;

		New(mob/user,mob/target,Command/c){
			..()
			mobRef = user
			targetRef = target
			cRef = c
			Conc=TRUE
			chCount++
			user._doEnergy(-1,TRUE)
			go(targetRef,cRef)
		}