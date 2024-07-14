fQuest_Factory
	questCheck(mob/m as mob){

		for(var/x in m.questData){
			switch(x){
				if("Q001_BREAKING_IT_IN"){
					if(isCompleted(m,x)) obtainQuest(m,"Q002_DEFEAT_THE_INVADER");
					if(isCompleted(m,x)) obtainQuest(m,"SQ007_SAIBAMEN_HUNT");
				}
				if("OG001_GLOBAL_TAKEOVER"){
					if(isCompleted(m,x)) obtainQuest(m,"OG002_FALL_OF_A_KING");
				}
				if("Q002_DEFEAT_THE_INVADER"){
					if(isCompleted(m,x)) obtainQuest(m,"Q003_PREPARE_FOR_THE_SAIYANS");
					if(isCompleted(m,x)) obtainQuest(m,"SQ001_OVER_9000");
				}

				if("Q003_PREPARE_FOR_THE_SAIYANS"){
					if(isCompleted(m,x)) obtainQuest(m,"Q004_PREPARE_FOR_THE_ELITE");
					if(isCompleted(m,x)) obtainQuest(m,"SQ002_HUNT_DBS");
				}

				if("Q004_PREPARE_FOR_THE_ELITE"){
					if(isCompleted(m,x)) obtainQuest(m,"Q005_TRAVEL_TO_NAMEK");
				}

				if("SQ003_TRAVEL_SNAKEWAY"){
					if(isCompleted(m,x)) obtainQuest(m,"SQ005_DEFEAT_SPIRIT_WARRIOR");
				}

				if("SQ005_DEFEAT_SPIRIT_WARRIOR"){
					if(isCompleted(m,x)) obtainQuest(m,"SQ004_DEFEAT_KING_KAI");
				}

				if("SQ004_DEFEAT_KING_KAI"){
					if(isCompleted(m,x)) obtainQuest(m,"Q003_PREPARE_FOR_THE_SAIYANS");
				}

				if("Q005_TRAVEL_TO_NAMEK"){
					if(isCompleted(m,x)) obtainQuest(m,"Q005_PEST_CONTROL");
					if(isCompleted(m,x)) obtainQuest(m,"Q006_FRIENDS_OF_A_WARRIOR");
					if(isCompleted(m,x)) obtainQuest(m,"Q007_ELITE_WARRIORS");
				}

				if("Q007_ELITE_WARRIORS"){
					if(isCompleted(m,x)) obtainQuest(m,"Q008_THE_LAST_SAIYANS");
				}

				if("Q008_THE_LAST_SAIYANS"){
					if(isCompleted(m,x)) obtainQuest(m,"Q009_THE_NAMEKIAN");
				}

				if("Q009_THE_NAMEKIAN"){
					if(isCompleted(m,x)) obtainQuest(m,"Q010_AN_EVIL_FORCE");
				}

				if("Q010_AN_EVIL_FORCE"){
					if(isCompleted(m,x)) obtainQuest(m,"Q011_DEADLY_DUO");
				}

				if("Q011_DEADLY_DUO"){
					if(isCompleted(m,x)) obtainQuest(m,"Q012_CELLS_MINIONS");
					if(isCompleted(m,x)) obtainQuest(m,"Q013_BIO_MASSACRE");
				}

				if("G004_ASCEND_OR_FALL"){
					if(isCompleted(m,x)){
						m.bonus_str = 700;
						m.bonus_arm = 700;
					}

				}

				if("S001_THE_LEGEND"){
					if(isCompleted(m,x) || m.race == LEGENDARY_SAIYAN){
						obtainQuest(m,"S002_THE_LEGEND");
					}

					if(m.race == LEGENDARY_SAIYAN){
						updateQuest(m,"S001_THE_LEGEND",m.questData["S001_THE_LEGEND"],TRUE);
					}
				}

				if("S002_THE_LEGEND"){
					if(m.race == LEGENDARY_SAIYAN){
						updateQuest(m,"S002_THE_LEGEND",m.questData["S002_THE_LEGEND"],TRUE);
					}
				}

				if("LS_01"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_02");
				}

				if("LS_02"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_03");
					if(isCompleted(m,x)) obtainQuest(m,"LS_04");
				}

				if("LS_03"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_05");
				}

				if("LS_05"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_06");
				}

				if("LS_06"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_07");
				}

				if("LS_07"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_08");
				}

				if("LS_08"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_09");
				}

				if("LS_09"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_10");
				}

				if("LS_10"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_11");
				}

				if("LS_11"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_12");
				}

				if("LS_12"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_13");
				}

				if("LS_13"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_14");
				}

				if("LS_14"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_15");
				}

				if("LS_15"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_16");
				}

				if("LS_16"){
					if(isCompleted(m,x)) obtainQuest(m,"LS_17");
				}
			}
		}
	}