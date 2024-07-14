fEAttk
	galick_gun
		name = "galick gun"
		text = "{M@{x"
		display = "{M@{x"
		pColor = "{m"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		chTime = 3 SECONDS;
		mxCh = 5;
		mnCh = 1;
		speed = 5;
		minDmg = GALICKGUN_MIN;
		maxDmg = GALICKGUN_MAX;
		enPerTick = GALICKGUN_EN_PERCH;
		dmgPerTick = GALICKGUN_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = GALICKGUN_COOLDOWN;

		New(){
			..()
			chargeMessages = list("galick gun grows in size")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell GALICK GUN!", list());
				..()
		}