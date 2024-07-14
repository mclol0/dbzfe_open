mob
	Player
		Demon
			bonus_str = 0; // BASE STR
			bonus_sta = 160; // BASE STAM
			bonus_arm = 160; // BASE ARMOR
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
										/Command/Technique/siphon,
										/Command/Technique/materialize);

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
							/Command/Technique/flameslash,
							/Command/Technique/hellfirelance,
							/Command/Technique/soulspear,
							///Command/Technique/perception,
							/Command/Technique/stone_spit,
							/Command/Technique/sk_throw,
							/Command/Technique/spin_kick,
							/Command/Technique/siphon,
							/Command/Technique/materialize,
							/Command/Technique/lure,
							/Command/Technique/slash,
							/Command/Technique/stab);

				}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}