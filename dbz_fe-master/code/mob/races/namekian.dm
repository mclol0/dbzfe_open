mob
	Player
		Namekian
			bonus_str = 20; // BASE STR
			bonus_sta = 20; // BASE STAM
			bonus_arm = 80; // BASE ARMOR

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
									/Command/Technique/snapneck,
									/Command/Technique/sense,
									/Command/Technique/scan,
									/Command/Technique/power,
									/Command/Technique/burst,
									/Command/Technique/super_hearing,
									/Command/Technique/namek_regeneration,
									/Command/Technique/namek_fuse)

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
								/Command/Technique/burst,
								/Command/Technique/sense,
								/Command/Technique/scan,
								/Command/Technique/power,
								/Command/Technique/snapneck,
								/Command/Technique/barrage,
								/Command/Technique/blast,
								/Command/Technique/super_hearing,
								/Command/Technique/namek_heal,
								/Command/Technique/namek_fuse,
								/Command/Technique/masenko,
								/Command/Technique/summon,
								/Command/Technique/kiaihou,
								/Command/Technique/specialbeamcannon,
								/Command/Technique/elbow,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/namek_regeneration,
								///Command/Technique/perception,
								/Command/Technique/sk_throw,
								/Command/Technique/makosen,
								/Command/Technique/spin_kick,
								/Command/Technique/teleport);
			}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}