proc
	stunned(mob/user, mob/target, stunnedTime=(world.time + 65), comboChance=fightComboChance){
		set waitfor = FALSE

		if(user.stunned){ return FALSE; } // We don't need to be stunned twice do we?

		user.stunTime = stunnedTime

		send("{R*{x {CYou are stunned!{x",user)
		send("{B*{x {CTECH BLOCK bonus!{x {C[user.raceColor(user.name)]{x{C is stunned!{x",target)
		send("{W*{x {CTECH BLOCK bonus!{x {C[user.raceColor(user.name)]{x{C is stunned!{x",a_oview_extra(0,user,target))
		if(decimal_prob(fightTechGainChance)) {
			if(istype(user,/mob/NPA) && user:difficultyLevel == EVENT_MOB) {
				target.gainPL(ret_percent((techGainPercent / 10),target.getMaxPL()),user)
			} else {
				target.gainPL(ret_percent(techGainPercent,target.getMaxPL()),user)
			}
		}
		user.stunned = TRUE;
		user.powering = FALSE;
		user.barrier = FALSE;
		user.cancelKi();

		if(decimal_prob(comboChance)){
			target:fCombat.buildCombo(user);
		}

		while(user && target){

			if(world.time >= user.stunTime || user.unconscious){
				if(target:fCombat.comboCount["[user.ID]"] > 1){
					var
						comboCount = target:fCombat.comboCount["[user.ID]"] - 1
						comboPercent = (comboGainPercent*comboCount)
						comboGain = ret_percent(comboPercent,target.getMaxPL())
					send("{B[comboCount]{x {Rhit combo!{x",target)
					if(decimal_prob(fightComboGainChance)) {
						if(istype(user,/mob/NPA) && user:difficultyLevel == EVENT_MOB) {
							target.gainPL((comboGain / 6),user)
						} else {
							target.gainPL(comboGain,user)
						}
					}
				}
				if(!user.unconscious){
					send("{B*{x {YYou regain movement!{x",user)
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y has regained movement!{x",_ohearers(0,user))
				}
				user.stunned = FALSE;
				user.stunTime = NULL;
				break;
			}
			sleep(world.tick_lag)
		}

		if(!target && user && user.stunned && !user.unconscious){
			send("{B*{x {YYou regain movement!{x",user)
			send("{W*{x {Y[user.raceColor(user.name)]{x{Y has regained movement!{x",_ohearers(0,user))
			user.stunned = FALSE;
			user.stunTime = NULL;
			return FALSE;
		}

		if(user && ("[user.ID]" in target.fCombat.comboList) || user && ("[user.ID]" in target.fCombat.comboCount)){
			target.fCombat.comboList.Remove("[user.ID]")
			target.fCombat.comboCount.Remove("[user.ID]")
		}
	}

	stumble(mob/user, mob/target, stunnedTime=(world.time + 65), comboChance=fightComboChance){
		set waitfor = FALSE

		if(user.stunned){ return FALSE; } // We don't need to be stunned twice do we?

		user.stunTime = stunnedTime

		send("{R*{x {CYou miss and stumble!  You are off balance and stunned!{x",user)
		send("{B*{x [user.raceColor(user.name)]{x{C stumbles and loses [user.determineSex(1)] balance! {C[user.raceColor(user.name)]{x{C is stunned!{x",target)
		send("{W*{x [user.raceColor(user.name)]{x{C stumbles and loses [user.determineSex(1)] balance! {C[user.raceColor(user.name)]{x{C is stunned!{x",a_oview_extra(0,user,target))

		if(decimal_prob(fightTechGainChance)) {
			if(istype(user,/mob/NPA) && user:difficultyLevel == EVENT_MOB) {
				target.gainPL(ret_percent((techGainPercent / 10),target.getMaxPL()),user)
			} else {
				target.gainPL(ret_percent(techGainPercent,target.getMaxPL()),user)
			}
		}

		user.stunned = TRUE;
		user.powering = FALSE;
		user.barrier = FALSE;
		user.cancelKi();

		if(decimal_prob(comboChance)){
			target:fCombat.buildCombo(user);
		}

		while(user && target){

			if(world.time >= user.stunTime || user.unconscious){
				if(target:fCombat.comboCount["[user.ID]"] > 1){
					var
						comboCount = target:fCombat.comboCount["[user.ID]"] - 1
						comboPercent = (comboGainPercent*comboCount)
						comboGain = ret_percent(comboPercent,target.getMaxPL())
					send("{B[comboCount]{x {Rhit combo!{x",target)
					if(decimal_prob(fightComboGainChance)) {
						if(istype(user,/mob/NPA) && user:difficultyLevel == EVENT_MOB) {
							target.gainPL((comboGain / 6),user)
						} else {
							target.gainPL(comboGain,user)
						}
					}
				}
				if(!user.unconscious){
					send("{B*{x {YYou regain balance!{x",user)
					send("{W*{x {Y[user.raceColor(user.name)]{x{Y has regained balance!{x",_ohearers(0,user))
				}
				user.stunned = FALSE;
				user.stunTime = NULL;
				break;
			}
			sleep(world.tick_lag)
		}

		if(!target && user && user.stunned && !user.unconscious){
			send("{B*{x {YYou regain balance!{x",user)
			send("{W*{x {Y[user.raceColor(user.name)]{x{Y has regained balance!{x",_ohearers(0,user))
			user.stunned = FALSE;
			user.stunTime = NULL;
			return FALSE;
		}

		if(user && ("[user.ID]" in target.fCombat.comboList) || user && ("[user.ID]" in target.fCombat.comboCount)){
			target.fCombat.comboList.Remove("[user.ID]")
			target.fCombat.comboCount.Remove("[user.ID]")
		}
	}
