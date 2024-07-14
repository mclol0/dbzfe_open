mob
	Player
		Legendary_Saiyan
			bonus_str = 280; // BASE STR
			bonus_sta = 0; // BASE STAM
			bonus_arm = 250; // BASE ARMOR

			startingSkills(){
				var/list/startingSkills = list(/Command/Technique/fly,
									/Command/Technique/kick,
									/Command/Technique/punch,
									/Command/Technique/roundhouse,
									/Command/Technique/sweep,
									/Command/Technique/parry,
									/Command/Technique/jump,
									/Command/Technique/duck,
									/Command/Technique/dodge,
									/Command/Technique/deflect,
									/Command/Technique/burst,
									/Command/Technique/sense,
									/Command/Technique/scan,
									/Command/Technique/power,
									/Command/Technique/snapneck,
									/Command/Technique/zenkai,
									/Command/Technique/barrier,
									/Command/Technique/Form/ssj,
									/Command/Technique/barrier,
									/Command/Technique/revert)

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
								/Command/Technique/summon,
								/Command/Technique/kiaihou,
								/Command/Technique/teleport,
								/Command/Technique/elbow,
								/Command/Technique/Form/ssj,
								/Command/Technique/Form/ssj2,
								/Command/Technique/Form/ssj3,
								/Command/Technique/Form/ssj4,
								/Command/Technique/revert,
								/Command/Technique/zenkai,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/renzoku,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/powerball,
								/Command/Technique/erasercannon,
								/Command/Technique/omegacannon,
								/Command/Technique/super_kamehameha,
								/Command/Technique/final_flash,
								/Command/Technique/barrier,
								/Command/Technique/kienzan)
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
								/Command/Technique/summon,
								/Command/Technique/teleport,
								/Command/Technique/Form/ssj2,
								/Command/Technique/Form/ssj3,
								/Command/Technique/kiaihou,
								/Command/Technique/elbow,
								/Command/Technique/Form/ssj,
								/Command/Technique/revert,
								/Command/Technique/zenkai,
								/Command/Technique/final_flash,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/renzoku,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/powerball,
								/Command/Technique/super_kamehameha,
								/Command/Technique/erasercannon,
								/Command/Technique/omegacannon,
								/Command/Technique/barrier,
								/Command/Technique/kienzan)
					}
				}
			}

			New(){
				..()

				icon = 'rsc/hu_ma.dmi'

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}