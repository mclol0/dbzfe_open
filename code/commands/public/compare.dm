proc
	vsCompare(_NUM1,_NUM2){
		if(_NUM1 > _NUM2){
			return "{G>{x";
		}else if(_NUM1 < _NUM2){
			return "{R<{x";
		}

		return "{Y={x";
	}

	compareItem(var/mob/m, var/obj/item/i, SLOT){

		var/compBuffer = NULL;
		var/obj/item/compare = m.equipment[SLOT];

		if(compare){
			compBuffer += "[i.DISPLAY] vs [compare.DISPLAY]\n"
			if(i.DESC) { compBuffer += "{m--------{x\n";compBuffer+="[i.DESC]\n";compBuffer += "{m--------{x\n" }
			compBuffer += "STA: [ncheck(i.BONUS_STA,999,m,TRUE)] [vsCompare(i.BONUS_STA,compare.BONUS_STA)] [ncheck(compare.BONUS_STA,999,m,TRUE)]\n"
			compBuffer += "KI: [ncheck(i.BONUS_KI,999,m,TRUE)] [vsCompare(i.BONUS_KI,compare.BONUS_KI)] [ncheck(compare.BONUS_KI,999,m,TRUE)]\n"
			compBuffer += "STRENGTH: [ncheck(i.BONUS_STR,999,m,TRUE)] [vsCompare(i.BONUS_STR,compare.BONUS_STR)] [ncheck(compare.BONUS_STR,999,m,TRUE)]\n"
			compBuffer += "ARMOR: [ncheck(i.BONUS_ARM,999,m,TRUE)] [vsCompare(i.BONUS_ARM,compare.BONUS_ARM)] [ncheck(compare.BONUS_ARM,999,m,TRUE)]\n"
			compBuffer += "MAGIC FIND: [ncheck(i.BONUS_MF,999,m,TRUE)] [vsCompare(i.BONUS_MF,compare.BONUS_MF)] [ncheck(compare.BONUS_MF,999,m,TRUE)]\n"
			compBuffer += "WEIGHT: {D[i.WEIGHT] kgs.{x [vsCompare(i.WEIGHT,compare.WEIGHT)] {D[compare.WEIGHT] kgs.{x\n"
		}else{
			compBuffer += "[i.DISPLAY] vs nothing\n"
			if(i.DESC) { compBuffer += "{m--------{x\n";compBuffer+="[i.DESC]\n";compBuffer += "{m--------{x\n" }
			compBuffer += "STA: [ncheck(i.BONUS_STA,999,m,TRUE)]\n"
			compBuffer += "KI: [ncheck(i.BONUS_KI,999,m,TRUE)]\n"
			compBuffer += "STRENGTH: [ncheck(i.BONUS_STR,999,m,TRUE)]\n"
			compBuffer += "ARMOR: [ncheck(i.BONUS_ARM,999,m,TRUE)]\n"
			compBuffer += "MAGIC FIND: [ncheck(i.BONUS_MF,999,m,TRUE)]\n"
			compBuffer += "WEIGHT: {D[i.WEIGHT] kgs.{x\n"
		}

		return compBuffer;
	}

Command/Public
	compare
		name = "compare"
		format = "~compare; ?~searc(obj@inventory)";
		syntax = list("item name")
		priority = 1
		canAlwaysUSE = TRUE;
		helpDescription = "Display a comparison of the selected item against the one currently equipped on the same slot. The comparison uses the following symbols to display the difference between stats:\n\n {G+{x {CBetter Stats{x\n {Y={x {CEqual stats{x\n {R-{x {CLower stats"
		cancelsPushups = FALSE;

		command(mob/user, obj/item/o) {
			if(o){
				if(o.SLOT == FINGERS){
					send(compareItem(user,o,LEFT_FINGER),user,TRUE);
					send(compareItem(user,o,RIGHT_FINGER),user,TRUE);
				}else{
					send(compareItem(user,o,o.SLOT),user,TRUE);
				}
			}
			else{
				syntax(user,src);
			}
		}