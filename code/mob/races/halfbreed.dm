mob
	Player
		Halfbreed
			bonus_str = 20; // BASE STR
			bonus_sta = 60; // BASE STAM
			bonus_arm = 20; // BASE ARMOR
			hasTail = TRUE;

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
									/Command/Technique/onslaught,
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
								/Command/Technique/blast,
								/Command/Technique/kamehameha,
								/Command/Technique/masenko,
								/Command/Technique/summon,
								/Command/Technique/renzoku,
								/Command/Technique/kiaihou,
								/Command/Technique/solar_flare,
								/Command/Technique/elbow,
								/Command/Technique/Form/ssj,
								/Command/Technique/Form/ssj2,
								/Command/Technique/revert,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/onslaught,
								/Command/Technique/Form/mystic,
								/Command/Technique/shyouken,
								/Command/Technique/burning_attack,
								/Command/Technique/finish_buster,
								/Command/Technique/sk_throw,
								/Command/Technique/super_kamehameha,
								/Command/Technique/spin_kick,
								/Command/Technique/teleport)
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
								/Command/Technique/blast,
								/Command/Technique/galick_gun,
								/Command/Technique/masenko,
								/Command/Technique/summon,
								/Command/Technique/renzoku,
								/Command/Technique/solar_flare,
								/Command/Technique/kiaihou,
								/Command/Technique/elbow,
								/Command/Technique/Form/ssj,
								/Command/Technique/Form/ssj2,
								/Command/Technique/revert,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/onslaught,
								/Command/Technique/Form/mystic,
								/Command/Technique/shyouken,
								/Command/Technique/burning_attack,
								/Command/Technique/finish_buster,
								/Command/Technique/sk_throw,
								/Command/Technique/final_flash,
								/Command/Technique/spin_kick,
								/Command/Technique/teleport)
					}
				}
			}

			New(){
				..()

				icon = 'rsc/hu_ma.dmi'

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}