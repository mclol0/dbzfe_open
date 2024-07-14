mob
	Player
		Spirit
			bonus_str = 20; // BASE STR
			bonus_sta = 140; // BASE STAM
			bonus_arm = 20; // BASE ARMOR

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
									/Command/Technique/revert,
									/Command/Technique/sense,
									/Command/Technique/scan,
									/Command/Technique/power,
									/Command/Technique/snapneck,                                    
                                    /Command/Technique/haunt,
                                    /Command/Technique/purify)

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
							/Command/Technique/sense,
							/Command/Technique/scan,
							/Command/Technique/power,
							/Command/Technique/snapneck,
							/Command/Technique/barrage,
							/Command/Technique/summon,
							/Command/Technique/revert,
                            /Command/Technique/phaserun,
                            /Command/Technique/spin_kick,
							/Command/Technique/blast,
							/Command/Technique/elbow,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/teleport,
                            /Command/Technique/kienzan,
							/Command/Technique/zanzoken,
							/Command/Technique/haunt,
                            /Command/Technique/purify,
                            /Command/Technique/Form/revenant,
							/Command/Technique/telekinesis,
							/Command/Technique/perception,
							/Command/Technique/spiritwave,
							/Command/Technique/pulse,
							/Command/Technique/divinecannon,
							/Command/Technique/consecrate)
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
							/Command/Technique/sense,
							/Command/Technique/scan,
							/Command/Technique/power,
							/Command/Technique/snapneck,
							/Command/Technique/barrage,
							/Command/Technique/summon,
							/Command/Technique/revert,
                            /Command/Technique/kienzan,
                            /Command/Technique/phaserun,
                            /Command/Technique/spin_kick,
							/Command/Technique/blast,
							/Command/Technique/elbow,
							/Command/Technique/hammer,
							/Command/Technique/uppercut,
							/Command/Technique/teleport,
							/Command/Technique/zanzoken,
							/Command/Technique/haunt,
                            /Command/Technique/purify,
                            /Command/Technique/Form/revenant,
							/Command/Technique/telekinesis,
							/Command/Technique/perception,
							/Command/Technique/spiritwave,
							/Command/Technique/pulse,
							/Command/Technique/divinecannon,
							/Command/Technique/consecrate)
					}
				}
			}

			New(){
				..()
				icon = 'rsc/hu_ma.dmi'
				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}
