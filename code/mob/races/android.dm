mob
	Player

		proc/gainlc(var/amount as num, var/mob/target as mob, OR = FALSE){
			if(maxpl > (target.maxpl * 6) && amount > 0 && !OR || target.maxpl > (getMaxPL() * 6) && amount < 0 && !OR || isSafe() && !OR || target.isSafe() && !OR) { return; }
			
			labcredits = clamp(labcredits + amount, 0, MAX_PL)

			/*if(amount<0){
				send("{R[commafy(amount,6)]{x lab credits!",src,TRUE)
			}else if(amount>0){
				send("{G+[commafy(amount,6)]{x lab credits!",src,TRUE)
			}*/

			lastLCGain = amount;

			if(target.client){ target.client.bust_prompt = TRUE; }

			saveSQLCharacter()
		}

		Android
			bonus_str = 30; // BASE STR
			bonus_sta = 50; // BASE STAM
			bonus_arm = 30; // BASE ARMOR

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
							/Command/Technique/super_hearing);
				}

			New(){
				..()

				senseDat = new /senseEnergy(src)
				fCombat = new /fCombat(src)
			}
