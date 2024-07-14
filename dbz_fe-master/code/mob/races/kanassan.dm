mob
	Player
		Kanassan
			bonus_str = 20; // BASE STR
			bonus_sta = 20; // BASE STAM
			bonus_arm = 60; // BASE ARMOR

			startingSkills(){
				var/list/startingSkills = list(/Command/Technique/fly,
									/Command/Technique/punch,
									/Command/Technique/kick,
									/Command/Technique/roundhouse,
									/Command/Technique/sweep,
									/Command/Technique/parry,
									/Command/Technique/jump,
									/Command/Technique/duck,
									/Command/Technique/dodge,
									/Command/Technique/deflect,
									/Command/Technique/sense,
									/Command/Technique/scan,
									/Command/Technique/power,
									/Command/Technique/snapneck,
									/Command/Technique/revert,
									/Command/Technique/burst)

				fixSkills(startingSkills);
			}

			skillSet(){
				switch(alignment){
					if(GOOD){
						return list(/Command/Technique/punch,
							/Command/Technique/kick,
							/Command/Technique/roundhouse,
							/Command/Technique/sweep,
							/Command/Technique/parry,
							/Command/Technique/jump,
							/Command/Technique/duck,
							/Command/Technique/dodge,
							/Command/Technique/deflect,
							/Command/Technique/fly,
							/Command/Technique/burst,
							/Command/Technique/sense,
							/Command/Technique/scan,
							/Command/Technique/power,
							/Command/Technique/snapneck,
							/Command/Technique/barrage,
							/Command/Technique/revert,
							/Command/Technique/blast)
					}

					if(EVIL){
						return list(/Command/Technique/punch,
							/Command/Technique/kick,
							/Command/Technique/roundhouse,
							/Command/Technique/sweep,
							/Command/Technique/parry,
							/Command/Technique/jump,
							/Command/Technique/duck,
							/Command/Technique/dodge,
							/Command/Technique/deflect,
							/Command/Technique/fly,
							/Command/Technique/burst,
							/Command/Technique/sense,
							/Command/Technique/scan,
							/Command/Technique/power,
							/Command/Technique/snapneck,
							/Command/Technique/barrage,
							/Command/Technique/revert,
							/Command/Technique/blast)
					}
				}
			}

			New(){
				..()
				icon = 'rsc/hu_ma.dmi'
				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}