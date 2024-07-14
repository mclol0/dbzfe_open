mob
	Player
		Kaio
			bonus_str = 20; // BASE STR
			bonus_sta = 40; // BASE STAM
			bonus_arm = 30; // BASE ARMOR

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
									///Command/Technique/perception,
									/Command/Technique/burst,
									/Command/Technique/revert,
									/Command/Technique/super_hearing)

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
								/Command/Technique/renzoku,
								/Command/Technique/kiaihou,
								/Command/Technique/elbow,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/kaio_heal,
								/Command/Technique/kizan,
								/Command/Technique/Form/mystic,
								/Command/Technique/masenko,
								/Command/Technique/spirit_bomb,
								/Command/Technique/Form/kaioken,
								/Command/Technique/Form/fullkaioken,
								/Command/Technique/revert,
								/Command/Technique/solar_flare,
								/Command/Technique/gekiretsu,
								/Command/Technique/teleport,
								/Command/Technique/super_hearing,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/aura_slide)

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
								/Command/Technique/renzoku,
								/Command/Technique/kiaihou,
								/Command/Technique/elbow,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/kaio_heal,
								/Command/Technique/masenko,
								/Command/Technique/kizan,
								/Command/Technique/Form/kaioken,
								/Command/Technique/Form/fullkaioken,
								/Command/Technique/revert,
								/Command/Technique/gekiretsu,
								/Command/Technique/teleport,
								/Command/Technique/super_hearing,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/Form/mystic,
								/Command/Technique/solar_flare,
								/Command/Technique/aura_slide)

					}
				}
			}

			New(){
				..()

				icon = 'rsc/hu_ma.dmi'

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}
