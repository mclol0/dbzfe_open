fEAttk
	retsuzan
		name = "retsuzan"
		text = "{M~{x"
		display = "{M~{x"
		pColor = "{M"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 40;
		chTime = 4 SECONDS;
		mxCh = 6;
		mnCh = 1;
		speed = 4;
		minDmg = RETSUZAN_MIN;
		maxDmg = RETSUZAN_MAX;
		enPerTick = RETSUZAN_EN_PERCH;
		dmgPerTick = RETSUZAN_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = RETSUZAN_COOLDOWN;

		New(){
			..()
			chargeMessages = list("stomach swells with energy")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell HAAAAAAAAAAAAA!!!", list());
				..()
		}