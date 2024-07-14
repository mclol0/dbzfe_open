fEAttk
	final_flash
		name = "final flash"
		text = "{Y0{x"
		display = "{Y0{x"
		pColor = "{y"
		isProjectile = TRUE;
		isCharge = TRUE;
		maxRange = 40;
		chTime = 4 SECONDS;
		mxCh = 6;
		mnCh = 1;
		speed = 5;
		minDmg = FINALFLASH_MIN;
		maxDmg = FINALFLASH_MAX;
		enPerTick = FINALFLASH_EN_PERCH;
		dmgPerTick = FINALFLASH_DAMAGE_PERCH;
		//density = TRUE;
		cdTime = FINALFLASH_COOLDOWN;

		New(){
			..()
			chargeMessages = list("final flash grows in size", "final flash has bolts of energy arcing around it")
			chargeAttk()
		}

		go(){
			if(isReady())
				alaparser.parse(mobRef, "yell FINAL FLASH!", list());
				..()
		}