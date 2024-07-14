mob
	Player
		Icer
			bonus_str = 50; // BASE STR
			bonus_sta = 30; // BASE STAM
			bonus_arm = 30; // BASE ARMOR
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
									/Command/Technique/snapneck,
									/Command/Technique/sense,
									/Command/Technique/telekinesis,
									/Command/Technique/scan,
									/Command/Technique/power,
									/Command/Technique/tail_whip,
									/Command/Technique/arrogance,
									/Command/Technique/revert,
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
								/Command/Technique/telekinesis,
								/Command/Technique/elbow,
								/Command/Technique/death_beam,
								/Command/Technique/tail_whip,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/arrogance,
								/Command/Technique/Form/form_2,
								/Command/Technique/Form/form_3,
								/Command/Technique/Form/form_4,
								/Command/Technique/Form/form_5,
								/Command/Technique/revert,
								/Command/Technique/teleport,
								///Command/Technique/perception,
								/Command/Technique/death_ball,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick,
								/Command/Technique/kienzan,
								/Command/Technique/eye_laser,
								/Command/Technique/Form/icer_goldform);
			}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}