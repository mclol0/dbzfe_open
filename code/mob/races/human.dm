mob
	Player
		Human
			bonus_str = 40; // BASE STR
			bonus_sta = 30; // BASE STAM
			bonus_arm = 40; // BASE ARMOR

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
							/Command/Technique/blast,
							/Command/Technique/kamehameha,
							/Command/Technique/summon,
							/Command/Technique/Form/kaioken,
							/Command/Technique/spirit_bomb,
							/Command/Technique/destructodisc,
							/Command/Technique/solar_flare,
							/Command/Technique/tri_beam,
							/Command/Technique/kiaihou,
							/Command/Technique/elbow,
							/Command/Technique/shyouken,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/Form/spirit_burst,
							/Command/Technique/revert,
							/Command/Technique/zanzoken,
							///Command/Technique/perception,
							/Command/Technique/sk_throw,
							/Command/Technique/super_kamehameha,
							/Command/Technique/wolf_fang_fist,
							/Command/Technique/spin_kick,
							/Command/Technique/teleport);
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
							/Command/Technique/masenko,
							/Command/Technique/summon,
							/Command/Technique/destructodisc,
							/Command/Technique/solar_flare,
							/Command/Technique/kiaihou,
							/Command/Technique/tri_beam,
							/Command/Technique/elbow,
							/Command/Technique/shyouken,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/Form/spirit_burst,
							/Command/Technique/revert,
							/Command/Technique/zanzoken,
							///Command/Technique/perception,
							/Command/Technique/sk_throw,
							/Command/Technique/super_kamehameha,
							/Command/Technique/wolf_fang_fist,
							/Command/Technique/spin_kick,
							/Command/Technique/teleport);
					}
				}
			}

			New(){
				..()
				icon = 'rsc/hu_ma.dmi'
				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}