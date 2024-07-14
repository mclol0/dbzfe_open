mob
	Player
		Saiyan
			bonus_str = 60; // BASE STR
			bonus_sta = 0; // BASE STAM
			bonus_arm = 40; // BASE ARMOR
			hasTail = TRUE;

			proc/makeLSSJ(){
				if(race == SAIYAN){
					form = "Normal";
					race = LEGENDARY_SAIYAN;
					maxpl = 5000;
					currpl = getMaxPL();
					maxeng = 150;
					curreng = getMaxEN();

					/* Strip Player Skills */
					techniques = list();
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
										/Command/Technique/revert);

					fixSkills(startingSkills);

					var/planet/area = get_area("vegeta");
					if(area){ warpArea(rand(1,area.dx),rand(1,area.dy),area); }

					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)

					send("{GYou feel reborn...{x", src);
					send("{GRelog to fix your skill tree...{x", src);
				}
			}

			startingSkills(){
				var/list/startingSkills = list(/Command/Technique/fly,
									/Command/Technique/kick,
									/Command/Technique/punch,
									/Command/Technique/roundhouse,
									/Command/Technique/sweep,
									/Command/Technique/parry,
									/Command/Technique/jump,
									/Command/Technique/duck,
									/Command/Technique/burst,
									/Command/Technique/dodge,
									/Command/Technique/deflect,
									/Command/Technique/sense,
									/Command/Technique/scan,
									/Command/Technique/power,
									/Command/Technique/snapneck,
									/Command/Technique/revert,
									/Command/Technique/zenkai)

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
								/Command/Technique/renzoku,
								/Command/Technique/kiaihou,
								/Command/Technique/teleport,
								/Command/Technique/elbow,
								/Command/Technique/Form/ssj,
								/Command/Technique/Form/ssj2,
								/Command/Technique/Form/ssj3,
								/Command/Technique/Form/ssj4,
								/Command/Technique/Form/ssjg,
								/Command/Technique/Form/ssjb,
								/Command/Technique/revert,
								/Command/Technique/powerball,
								/Command/Technique/zenkai,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								///Command/Technique/perception,
								/Command/Technique/sk_throw,
								/Command/Technique/super_kamehameha,
								/Command/Technique/spin_kick)
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
								/Command/Technique/galick_gun,
								/Command/Technique/summon,
								/Command/Technique/teleport,
								/Command/Technique/renzoku,
								/Command/Technique/kiaihou,
								/Command/Technique/elbow,
								/Command/Technique/Form/ssj,
								/Command/Technique/Form/ssj2,
								/Command/Technique/Form/ssj3,
								/Command/Technique/Form/ssj4,
								/Command/Technique/Form/ssjg,
								/Command/Technique/Form/ssjr,
								/Command/Technique/revert,
								/Command/Technique/powerball,
								/Command/Technique/zenkai,
								/Command/Technique/final_flash,
								/Command/Technique/hammer,
								/Command/Technique/uppercut,
								/Command/Technique/zanzoken,
								/Command/Technique/big_bang,
								/Command/Technique/sk_throw,
								/Command/Technique/spin_kick)
					}
				}
			}

			New(){
				..()

				icon = 'rsc/hu_ma.dmi'

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}