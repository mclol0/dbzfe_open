mob
	Player

		Immortal
			bonus_str = 0; // BASE STR
			bonus_sta = 0; // BASE STAM
			bonus_arm = 0; // BASE ARMOR

			var/list/defaultSkills = list()

			startingSkills(){
				var/list/startingSkills = list();

				for(var/X in typesof(/Command/Technique)){
					startingSkills += X;
					defaultSkills += X;
				}

				fixSkills(startingSkills);
			}

			skillSet(){
				return defaultSkills
			}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}