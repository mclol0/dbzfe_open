mob
	Player
		Genie
			bonus_str = 50; // BASE STR
			bonus_sta = 0; // BASE STAM
			bonus_arm = 100; // BASE ARMOR

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
									/Command/Technique/genie_regeneration,
									/Command/Technique/candy_beam,
									/Command/Technique/genie_assimilate,
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
								/Command/Technique/kiaihou,
								/Command/Technique/burst,
								/Command/Technique/sense,
								/Command/Technique/scan,
								/Command/Technique/power,
								/Command/Technique/snapneck,
								/Command/Technique/barrage,
								/Command/Technique/blast,
								/Command/Technique/summon,
								/Command/Technique/teleport,
								/Command/Technique/elbow,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								///Command/Technique/perception,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/candy_beam,
								/Command/Technique/genie_regeneration,
								/Command/Technique/gack,
								/Command/Technique/vanishing_beam,
								/Command/Technique/mend,
								/Command/Technique/kaikosen,
								/Command/Technique/retsuzan,
								/Command/Technique/energy_mine,
								/Command/Technique/genie_assimilate)
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
								/Command/Technique/kiaihou,
								/Command/Technique/snapneck,
								/Command/Technique/barrage,
								/Command/Technique/blast,
								/Command/Technique/summon,
								/Command/Technique/teleport,
								/Command/Technique/elbow,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								///Command/Technique/perception,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/candy_beam,
								/Command/Technique/genie_regeneration,
								/Command/Technique/gack,
								/Command/Technique/vanishing_beam,
								/Command/Technique/mend,
								/Command/Technique/kaikosen,
								/Command/Technique/retsuzan,
								/Command/Technique/energy_mine,
								/Command/Technique/genie_assimilate)
					}
				}
			}

			New(){
				..()

				icon = 'rsc/hu_ma.dmi'

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}