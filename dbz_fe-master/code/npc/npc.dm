mob
	NPA
		Move(){
			if(DEAD){ return FALSE; } else { ..() }
		}

		var
			startx
			starty
			startz
			respawnTime = 5 MINUTES;
			respawn = TRUE;
			hostile = FALSE;
			single_name = NULL;
			multi_name = NULL;
			teach[] = list()
			list/teachDelayed = list() // Does the mob teach something on a different form? If yes. formname = list(skills) - for help files
			list/teachShow = list()		// Show the Teach, but don't grant it on kill
			dropList[] = list();
			randomRespawn = TRUE
			AGGRO = FALSE; // Do we aggro players in view?
			DEAD = FALSE; // Are we dead?
			shopSale = FALSE;
			isStore = FALSE; // Is this a store mob?
			list/storeInventory[0]

		New(){
			..()

			game.mobiles += src;
			if(AGGRO){ game.aggroMobs += src; }

			fCombat = new /fCombat(src)
			startx = x
			starty = y
			startz = z
			techniques.Add(/Command/Technique/fly,
								/Command/Technique/punch,
								/Command/Technique/roundhouse,
								/Command/Technique/sweep,
								/Command/Technique/parry,
								/Command/Technique/jump,
								/Command/Technique/duck,
								/Command/Technique/dodge,
								/Command/Technique/power,
								/Command/Technique/snapneck,
								/Command/Technique/deflect,
								/Command/Technique/onslaught,
								/Command/Technique/revert)

			spawn() bonus_str = (bonus_str + getBonusSTR());
			spawn() bonus_arm = (bonus_arm + getBonusARM());

			curreng = getMaxEN()
			currpl = getMaxPL()

			checkForPlayers()
			dropList.Add(/obj/item/MYSTERY_BOX);
			dropList.Add(/obj/item/DRAGON_RADAR);
			dropList.Add(/obj/item/GOLD_BAR);
			dropList.Add(/obj/item/SILVER_BAR);
		}

		Del(){
			game.mobiles -= src;
			if(AGGRO){ game.aggroMobs -= src; }

			if(respawn){
				if(alliedType.len > 0){ respawnTime = 5 MINUTES; }

				new /respawnMob(type,randomRespawn,startx,starty,startz,getArea(),respawnTime)
			}

			..()
		}

		display = "{M*{x"
		text = "<font color=magenta>*</font>"
