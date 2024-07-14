mob
	Player
		Alien
			bonus_str = 80; // BASE STR
			bonus_sta = 80; // BASE STAM
			bonus_arm = 80; // BASE ARMOR

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
							/Command/Technique/summon,
							/Command/Technique/revert,
							/Command/Technique/blast,
							/Command/Technique/elbow,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/sk_throw,
							/Command/Technique/spin_kick,
							/Command/Technique/fury,
							/Command/Technique/timeskip,
							/Command/Technique/teleport,
							/Command/Technique/energy_mine,
							/Command/Technique/Form/enhance,
							/Command/Technique/zanzoken,
							/Command/Technique/renzoku,
							/Command/Technique/eye_laser,
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
							/Command/Technique/summon,
							/Command/Technique/revert,
							/Command/Technique/blast,
							/Command/Technique/elbow,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/sk_throw,
							/Command/Technique/spin_kick,
							/Command/Technique/fury,
							/Command/Technique/timeskip,
							/Command/Technique/teleport,
							/Command/Technique/energy_mine,
							/Command/Technique/Form/enhance,
							/Command/Technique/zanzoken,
							/Command/Technique/renzoku,
							/Command/Technique/eye_laser,
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