fEAttk
	makosen
		name = "makosen"
		text = "{B@{x"
		display = "{B@{x"
		pColor = "{C"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 20;
		chTime = 3 SECONDS;
		mxCh = 5;
		mnCh = 1;
		speed = 5;
		minDmg = MAKOSEN_MIN;
		maxDmg = MAKOSEN_MAX;
		enPerTick = MAKOSEN_EN_PERCH;
		//density = TRUE;
		cdTime = MAKOSEN_COOLDOWN;
		dmgPerTick = MAKOSEN_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("makosen grows in size")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell MAKOSEN!", list());
				..()
		}