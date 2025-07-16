mob
	Player
		Remort_Android
			bonus_str = 50; // BASE STR
			bonus_sta = 150; // BASE STAM
			bonus_arm = 250; // BASE ARMOR

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
										/Command/Technique/absorb,
										/Command/Technique/revert,
										/Command/Technique/barrier,
										/Command/Technique/deflect,
										/Command/Technique/upgrade,
										/Command/Technique/sense,
										/Command/Technique/scan,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/burst)

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
							/Command/Technique/absorb,
							/Command/Technique/fly,
							/Command/Technique/burst,
							/Command/Technique/sense,
							/Command/Technique/scan,
							/Command/Technique/power,
							/Command/Technique/upgrade,
							/Command/Technique/revert,
							/Command/Technique/snapneck,
							/Command/Technique/barrage,
							/Command/Technique/blast,
							/Command/Technique/mask,
							/Command/Technique/barrier,
							/Command/Technique/summon,
							/Command/Technique/elbow,
							/Command/Technique/eye_laser,
							/Command/Technique/drain,
							/Command/Technique/hikou,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/zanzoken,
							/Command/Technique/sk_throw,
							/Command/Technique/spin_kick,
							/Command/Technique/rocketpunch,
							/Command/Technique/teleport,
							/Command/Technique/power_blitz,
							/Command/Technique/super_hearing,
							/Command/Technique/Form/overclock);
				}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}
