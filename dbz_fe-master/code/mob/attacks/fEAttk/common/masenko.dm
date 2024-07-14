fEAttk
	masenko
		name = "masenko"
		text = "{yo{x"
		display = "{yo{x"
		pColor = "{Y"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		chTime = 20;
		mxCh = 4;
		mnCh = 1;
		speed = 4;
		minDmg = MASENKO_MIN;
		maxDmg = MASENKO_MAX;
		enPerTick = MASENKO_EN_PERCH;
		//density = TRUE;
		cdTime = MASENKO_COOLDOWN;
		dmgPerTick = MASENKO_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("masenko grows in size","masenko grows in intensity")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell MASENKO HA!", list());
				..()
		}