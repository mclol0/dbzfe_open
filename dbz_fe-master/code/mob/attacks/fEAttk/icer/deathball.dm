fEAttk
	death_ball
		name = "deathball"
		text = "{MO{x"
		display = "{MO{x"
		pColor = NULL;
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 60;
		chTime = 3 SECONDS;
		mxCh = 5;
		mnCh = 3;
		speed = 5;
		minDmg = DEATHBALL_MIN;
		maxDmg = DEATHBALL_MAX;
		enPerTick = DEATHBALL_EN_PERCH;
		cdTime = DEATHBALL_COOLDOWN;
		dmgPerTick = DEATHBALL_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("death ball grows in size")
			chargeAttk()
		}