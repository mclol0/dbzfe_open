fQuest_Factory
	getRewards(var/quest as text, mob/m as mob){
		var/fQuest/Q = qFac.get(quest);
		send("{GYou have completed the quest [Q.name]!{x",m,TRUE);

		updateQuest(m,quest,m.questData[quest],TRUE);

		switch(quest){
			if("OG001_GLOBAL_TAKEOVER"){
				obtainQuest(m,"OG002_FALL_OF_A_KING");
				if(m.race == ANDROID){ m:gainlc(2,m,TRUE); }else{ m.gainPL(50,m); }
			}

			if("SQ007_SAIBAMEN_HUNT"){
				if(m.race == ANDROID){ m:gainlc(4,m,TRUE); }else{ m.gainPL(300,m); }
			}

			if("Q001_BREAKING_IT_IN"){
				obtainQuest(m,"Q002_DEFEAT_THE_INVADER");
				obtainQuest(m,"SQ007_SAIBAMEN_HUNT");
				if(m.race == ANDROID){ m:gainlc(2,m,TRUE); }else{ m.gainPL(50,m); }
			}

			if("OG002_FALL_OF_A_KING"){
				if(m.race == ANDROID){ m:gainlc(2,m,TRUE); }else{ m.gainPL(50,m); }
			}

			if("Q002_DEFEAT_THE_INVADER"){
				obtainQuest(m,"Q003_PREPARE_FOR_THE_SAIYANS");
				obtainQuest(m,"SQ001_OVER_9000");
				if(m.race == ANDROID){ m:gainlc(3,m,TRUE); }else{ m.gainPL(200,m); }
			}

			if("SQ001_OVER_9000"){
				if(m.race == ANDROID){ m:gainlc(5,m,TRUE); }else{ m.gainPL(1000,m); }
				awardItem(m,/obj/item/CANDY);
			}

			if("SQ002_HUNT_DBS"){
				var/items = list(/obj/item/PORUNGAS_DRAGON_EYE,
				/obj/item/PORUNGAS_HORNS,
				/obj/item/PORUNGAS_LENSES_OF_DEFIANCE,
				/obj/item/PORUNGAS_GAUGES,
				/obj/item/PORUNGAS_DRAGON_BONE_BEVOR,
				/obj/item/PORUNGAS_SPIKED_PAULDRONS,
				/obj/item/PORUNGAS_DORSAL_FIN,
				/obj/item/PORUNGAS_INDOMINABLE_CUIRASS,
				/obj/item/PORUNGAS_DRAGON_BONE_FAULDS,
				/obj/item/PORUNGAS_DRAGON_SCALE_VAMBRACES,
				/obj/item/PORUNGAS_PADDED_WRISTGUARDS,
				/obj/item/PORUNGAS_HARDENED_GAUNTLETS,
				/obj/item/PORUNGAS_DRAGON_SCALE_CHAUSSES,
				/obj/item/PORUNGAS_JOINTED_BRACE,
				/obj/item/PORUNGAS_TEMPERED_SABATONS)

				awardItem(m,pick(items));
			}

			if("Q003_PREPARE_FOR_THE_SAIYANS"){
				awardItem(m,/obj/item/SCOUTER);
				obtainQuest(m,"Q004_PREPARE_FOR_THE_ELITE");
				if(m.race == ANDROID){ m:gainlc(6,m,TRUE); }else{ m.gainPL(500,m); }
			}

			if("Q004_PREPARE_FOR_THE_ELITE"){
				obtainQuest(m,"Q004_TRAVEL_TO_NAMEK");
				obtainQuest(m,"SQ002_HUNT_DBS");
				m:learnSkill("summon")
			}

			if("Q004_TRAVEL_TO_NAMEK"){
				obtainQuest(m,"Q005_PEST_CONTROL");
				obtainQuest(m,"Q006_FRIENDS_OF_A_WARRIOR");
				obtainQuest(m,"Q007_ELITE_WARRIORS");
				awardItem(m,/obj/item/SENZU_BEAN);
			}

			if("SQ003_TRAVEL_SNAKEWAY"){
				m.gainPL(250,m);
				obtainQuest(m,"SQ005_DEFEAT_SPIRIT_WARRIOR");
			}

			if("SQ005_DEFEAT_SPIRIT_WARRIOR"){
				m.gainPL(500,m);
				obtainQuest(m,"SQ004_DEFEAT_KING_KAI");
			}

			if("SQ004_DEFEAT_KING_KAI"){
				awardItem(m,/obj/item/KING_KAI_INSIGNIA);
				obtainQuest(m,"Q003_PREPARE_FOR_THE_SAIYANS");
				m.gainPL(4000,m);
			}

			if("Q005_PEST_CONTROL"){
				m.gainPL(2500,m);
			}

			if("Q006_FRIENDS_OF_A_WARRIOR"){
				awardItem(m,/obj/item/MYSTERY_BOX);
			}

			if("Q007_ELITE_WARRIORS"){
				var/rewardRing = pick(/obj/item/SAPPHIRE_GRAVITY_RING,
					/obj/item/RUBY_RING_OF_BLOODSHED,
					/obj/item/GOLDEN_RING_OF_AVARICE,
					/obj/item/STALWART_DIAMOND_RING,
					/obj/item/EMERALD_VITALITY_RING,
					/obj/item/OPAL_RING_OF_SPIRIT);

				m.gainPL(10000,m);
				awardItem(m,rewardRing);
				obtainQuest(m,"Q008_THE_LAST_SAIYANS");
			}

			if("Q008_THE_LAST_SAIYANS"){
				m.gainPL(25000,m);
				awardItem(m,/obj/item/MYSTERY_BOX);
				obtainQuest(m,"Q009_THE_NAMEKIAN");
			}

			if("Q009_THE_NAMEKIAN"){
				m.gainPL(30000,m);
				obtainQuest(m,"Q010_AN_EVIL_FORCE");
			}

			if("Q010_AN_EVIL_FORCE"){
				m.gainPL(100000,m);
				awardItem(m,/obj/item/MYSTERY_BOX);
				obtainQuest(m,"Q011_DEADLY_DUO");
			}

			if("Q011_DEADLY_DUO"){
				m.gainPL(500000,m);
				awardItem(m,/obj/item/SENZU_BEAN);
			}

			if("Q012_CELLS_MINIONS"){
				m.gainPL(500000,m);
				awardItem(m,/obj/item/SENZU_BEAN);
			}

			if("Q013_BIO_MASSACRE"){
				m.gainPL(500000,m);
				awardItem(m,/obj/item/MYSTERY_BOX);
				awardItem(m,/obj/item/SENZU_BEAN);
			}

			if("SQ006_PURIFICATION"){
				var/planet/area = get_area("earth")

				if(area){
					m.warpArea(rand(1,area.dx),rand(1,area.dy),area)

					send(buildMap(m,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),m);
					send("You have been warped back to [area.name]!",m)
					awardItem(m,/obj/item/HFILFIRE_BRAND);
				}else{
					send("ERROR: Uh-oh something bad has happened!",m)
				}
				m.gainPL(4000,m);
			}

			if("SAIYANQ001_THE_LEGEND"){
				awardItem(m,/obj/item/GOKUS_ORANGE_GI);
			}

			if("G004_ASCEND_OR_FALL"){
				awardItem(m,/obj/item/X0_JIZZ_STAINED_HAKAMA);
				m.bonus_str = 700;
				m.bonus_arm = 700;
			}

			if("G001_REACH_FOR_GODHOOD"){
				obtainQuest(m,"G002_CONFRONT_DESTRUCTION");
				awardItem(m,/obj/item/CANDY);
				awardItem(m,/obj/item/CANDY);
			}

			if("G002_CONFRONT_DESTRUCTION"){
				awardItem(m,/obj/item/ARMBANDS_OF_DESTRUCTION);
				awardItem(m,/obj/item/SENZU_BEAN);
				obtainQuest(m,"G003_PATH_TO_ENLIGHTENMENT")
			}

			if("G003_PATH_TO_ENLIGHTENMENT"){
				awardItem(m,/obj/item/SENZU_BEAN);
				awardItem(m,/obj/item/SENZU_BEAN);
				awardItem(m,/obj/item/SENZU_BEAN);
				awardItem(m,/obj/item/SENZU_BEAN);
				awardItem(m,/obj/item/SENZU_BEAN);
				obtainQuest(m,"G004_ASCEND_OR_FALL")
			}

			if("S001_THE_LEGEND"){
				obtainQuest(m,"S002_THE_LEGEND");
			}

			if("S002_THE_LEGEND"){
				m:makeLSSJ();
			}

			if("LS_01"){
				m.gainPL(500,m);
			}

			if("LS_02"){
				m.gainPL(500,m);
			}

			if("LS_03"){
				m.gainPL(500,m);
			}

			if("LS_04"){
				m.gainPL(500,m);
			}

			if("LS_05"){
				m.gainPL(500,m);
				awardItem(m,/obj/item/KING_VEGETA_CAPE);
				m:learnSkill("summon");
			}

			if("LS_06"){
				m.gainPL(800,m);
			}

			if("LS_07"){
				m.gainPL(1000,m);
			}

			if("LS_08"){
				m.gainPL(1500,m);
			}

			if("LS_09"){
				m.gainPL(50000,m);
			}

			if("LS_10"){
				m.gainPL(100000,m);
			}

			if("LS_11"){
				m.gainPL(100000,m);
			}

			if("LS_12"){
				m.gainPL(200000,m);
			}

			if("LS_13"){
				m.gainPL(2000000,m);
			}

			if("LS_14"){
				m.gainPL(8000000,m);
			}

			if("LS_15"){
				m.gainPL(5200000,m);
			}

			if("LS_16"){
				m.gainPL(15200000,m);
				awardItem(m,/obj/item/GOKUS_BLUE_GI);
			}

			if("LS_17"){
				m.gainPL(555200000,m);
				awardItem(m,/obj/item/BROLYS_EARRINGS);
			}
		}

		qFac.questCheck(m);
	}