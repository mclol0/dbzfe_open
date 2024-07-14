fEAttk
	spirit_bomb
		name = "spirit bomb"
		text = "{WO{x"
		display = "{WO{x"
		pColor = NULL;
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 60;
		chTime = 6 SECONDS;
		mxCh = 10;
		mnCh = 5;
		speed = 10;
		minDmg = SPIRITBOMB_MIN;
		maxDmg = SPIRITBOMB_MAX;
		enPerTick = SPIRITBOMB_EN_PERCH;
		cdTime = SPIRITBOBM_COOLDOWN;
		dmgPerTick = SPIRITBOMB_DAMAGE_PERCH;

		New(){
			..()
			chargeMessages = list("spirit bomb grows in size")
			chargeAttk()
		}