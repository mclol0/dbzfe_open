mob
	Player
		Bio_Android
			bonus_str = 150; // BASE STR
			bonus_sta = 80; // BASE STAM
			bonus_arm = 100; // BASE ARMOR
			hasTail = FALSE;

			startingSkills(){
				var/list/startingSkills = list(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/kick,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/hikou,
										/Command/Technique/burst,
										/Command/Technique/dodge,
										/Command/Technique/deflect,
										/Command/Technique/sense,
										/Command/Technique/scan,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/bio_assimilate,
										/Command/Technique/tail_stab);

				fixSkills(startingSkills);
			}

			skillSet(){
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
							/Command/Technique/sense,
							/Command/Technique/scan,
							/Command/Technique/power,
							/Command/Technique/snapneck,
							/Command/Technique/barrage,
							/Command/Technique/teleport,
							/Command/Technique/blast,
							/Command/Technique/burst,
							/Command/Technique/summon,
							/Command/Technique/elbow,
							/Command/Technique/hikou,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/zanzoken,
							/Command/Technique/bio_assimilate,
							/Command/Technique/hellfirelance,
							/Command/Technique/stone_spit,
							/Command/Technique/sk_throw,
							/Command/Technique/final_flash,
							/Command/Technique/kamehameha,
							/Command/Technique/masenko,
							/Command/Technique/specialbeamcannon,
							/Command/Technique/tri_beam,
							/Command/Technique/death_beam,
							/Command/Technique/eye_laser,
							/Command/Technique/super_kamehameha,
							/Command/Technique/tail_stab,
							/Command/Technique/spin_kick,
							/Command/Technique/bio_absorb);

				}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}