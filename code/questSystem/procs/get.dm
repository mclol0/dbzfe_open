fQuest_Factory
	get(var/request as text){
		var/fQuest/o = new objectType;

		switch(request){
			if("OG001_GLOBAL_TAKEOVER"){
				o.internal_name = "OG001_GLOBAL_TAKEOVER"
				o.name = "Global Takeover";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/RedRibbonSoldier)" = 5,"hasKilled(/mob/NPA/earth/General_Tao)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/RedRibbonSoldier)" = 0,"hasKilled(/mob/NPA/earth/General_Tao)" = 0);
				o.desc = {"The Red Ribbon Army is making it's move! Stop General Tao and the Red Ribbon Soldiers!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 1;
			}

			if("AL001_AFTER_LIFE"){
				o.internal_name = "AL001_AFTER_LIFE"
				o.name = "Life After?";
				o.completedVariables = list("hasItem" = /obj/item/HEAVENLY_HALO);
				o.savedVariables = NULL
				o.desc = {"Answer that universal question, what happens when I die?!(do it before 20kpl)"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD);
				o.internal_id = 2;
			}

			if("AD001_AFTER_DEATH"){
				o.internal_name = "AD001_AFTER_DEATH"
				o.name = "Life After?";
				o.completedVariables = list("hasItem" = /obj/item/HFILFIRE_HORNS);
				o.savedVariables = NULL
				o.desc = {"Answer that universal question, what happens when I die?!(do it before 20kpl)"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(EVIL);
				o.internal_id = 3;
			}

			if("Q001_BREAKING_IT_IN"){
				o.internal_name = "Q001_BREAKING_IT_IN"
				o.name = "Choose your Path";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/MasterRoshi)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/MasterRoshi)" = 0);
				o.desc = {"Seek stronger opponenets!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 4;
			}

			if("SQ007_SAIBAMEN_HUNT"){
				o.internal_name = "SQ007_SAIBAMEN_HUNT"
				o.name = "What's That? SAIBAMEN!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Saibaman)" = 10);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Saibaman)" = 0);
				o.desc = {"Not set."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 5;
			}

			if("Q002_DEFEAT_THE_INVADER"){
				o.internal_name = "Q002_DEFEAT_THE_INVADER"
				o.name = "Galactic invaders!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/FriezaHenchman)" = 2);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/FriezaHenchman)" = 0);
				o.desc = {"An Alien race has invaded the earth, focused on destruction! "}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 6;
			}

			if("SQ003_TRAVEL_SNAKEWAY"){
				o.internal_name = "SQ003_TRAVEL_SNAKEWAY"
				o.name = "Travel Snakeway";
				o.completedVariables = list("Travel Snakeway" = TRUE);
				o.savedVariables = list("Travel Snakeway" = FALSE);
				o.desc = {"You failed Planet Earth in defeating Raditz. Hurry and reach the end of snakeway!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 7;
			}

			if("SQ004_DEFEAT_KING_KAI"){
				o.internal_name = "SQ004_DEFEAT_KING_KAI"
				o.name = "Defeat King Kai";
				o.completedVariables = list("hasKilled(/mob/NPA/kaio_planet/KingKai)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/kaio_planet/KingKai)" = 0);
				o.desc = {"You have completed snakeway and defeated the {WSpirit Warrior{x now defeat {CKing Kai{x to get back to Earth!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD);
				o.internal_id = 8;
			}

			if("SQ005_DEFEAT_SPIRIT_WARRIOR"){
				o.internal_name = "SQ005_DEFEAT_SPIRIT_WARRIOR"
				o.name = "Defeat Warrior Spirit";
				o.completedVariables = list("hasKilled(/mob/NPA/kaio_planet/WarriorSpirit)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/kaio_planet/WarriorSpirit)" = 0);
				o.desc = {"You have completed snakeway now defeat the {WWarrior Spirit{x to prove to {CKing Kai{x you're elligble for his training!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD);
				o.internal_id = 9;
			}

			if("SQ001_OVER_9000"){
				o.internal_name = "SQ001_OVER_9000"
				o.name = "It's over 9000!!!!";
				o.completedVariables = list("hasPower" = 9000);
				o.savedVariables = NULL;
				o.desc = {"IT'S OVER 9000!!!!!!!!!!!!!!!!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 10;
			}

			if("SQ002_HUNT_DBS"){
				o.internal_name = "SQ002_HUNT_DBS"
				o.name = "Hunting for the Dragonballs";
				o.completedVariables = list("Make a wish" = TRUE/*"hasItem" = /obj/item/DRAGONBALLS/ONE_STAR_DRAGONBALL, "hasItem2" = /obj/item/DRAGONBALLS/TWO_STAR_DRAGONBALL, "hasItem3" = /obj/item/DRAGONBALLS/THREE_STAR_DRAGONBALL, "hasItem4" = /obj/item/DRAGONBALLS/FOUR_STAR_DRAGONBALL, "hasItem5" = /obj/item/DRAGONBALLS/FIVE_STAR_DRAGONBALL, "hasItem6" = /obj/item/DRAGONBALLS/SIX_STAR_DRAGONBALL, "hasItem7" = /obj/item/DRAGONBALLS/SEVEN_STAR_DRAGONBALL*/);
				o.savedVariables = list("Make a wish" = FALSE);
				o.desc = {"The Dragon Balls were intended to be a thing of extraordinary magic and power, something to be revered, not for the ease of their method, but for the dream of never having to use them."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 11;
			}

			if("Q003_PREPARE_FOR_THE_SAIYANS"){
				o.internal_name = "Q003_PREPARE_FOR_THE_SAIYANS"
				o.name = "Confront the Saiyan!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Raditz)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Raditz)" = 0);
				o.desc = {"A terrifying power has appeared on earth! Earthlings are dying?!?!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 12;
			}

			if("OG002_FALL_OF_A_KING"){
				o.internal_name = "OG002_FALL_OF_A_KING"
				o.name = "Alien presence!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/KingPiccolo)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/KingPiccolo)" = 0);
				o.desc = {"A terrifying power has appeared on earth! Earthlings are dying?!?!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 13;
			}

			if("Q004_PREPARE_FOR_THE_ELITE"){
				o.internal_name = "Q004_PREPARE_FOR_THE_ELITE"
				o.name = "Prepare for the Saiyans!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Nappa)" = 1,"hasKilled(/mob/NPA/earth/Vegeta)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Nappa)" = 0,"hasKilled(/mob/NPA/earth/Vegeta)" = 0);
				o.desc = {"Raditz warned you more of his kind were coming! Something tells you it's only just begun. "}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 14;
			}

			if("Q004_TRAVEL_TO_NAMEK"){
				o.internal_name = "Q004_TRAVEL_TO_NAMEK"
				o.name = "Travel to Namek!";
				o.completedVariables = list("Travel to Namek" = TRUE);
				o.savedVariables = list("Travel to Namek" = FALSE);
				o.desc = {"After defeating the Saiyans {cVegeta{x and {cNappa{x you hear of a story of magical balls on Planet Namek venture there to find more information!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 15;
			}

			if("Q006_PEST_CONTROL"){
				o.internal_name = "Q006_PEST_CONTROL"
				o.name = "Pest Control";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/NamekianElite)" = 10);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/NamekianElite)" = 0);
				o.desc = {"Clean up Nameks local inhabitants."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 16;
			}

			if("Q006_FRIENDS_OF_A_WARRIOR"){
				o.internal_name = "Q006_FRIENDS_OF_A_WARRIOR"
				o.name = "Friends of a Warrior";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Krillin)" = 1,"hasKilled(/mob/NPA/namek/Gohan)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Krillin)" = 0,"hasKilled(/mob/NPA/namek/Gohan)" = 0);
				o.desc = {"Not set."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 17;
			}

			if("Q007_ELITE_WARRIORS"){
				o.internal_name = "Q007_ELITE_WARRIORS"
				o.name = "Elite Warriors";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Guldo)" = 1,"hasKilled(/mob/NPA/namek/Recoome)" = 1,"hasKilled(/mob/NPA/namek/Burter)" = 1,"hasKilled(/mob/NPA/namek/Jeice)" = 1,"hasKilled(/mob/NPA/namek/CaptainGinyu)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Guldo)" = 0,"hasKilled(/mob/NPA/namek/Recoome)" = 0,"hasKilled(/mob/NPA/namek/Burter)" = 0,"hasKilled(/mob/NPA/namek/Jeice)" = 0,"hasKilled(/mob/NPA/namek/CaptainGinyu)" = 0);
				o.desc = {"Defeat the Ginyu Force."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 18;
			}

			if("Q008_THE_LAST_SAIYANS"){
				o.internal_name = "Q008_THE_LAST_SAIYANS"
				o.name = "The Last Saiyans";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Vegeta)" = 1,"hasKilled(/mob/NPA/namek/Goku)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Vegeta)" = 0,"hasKilled(/mob/NPA/namek/Goku)" = 0);
				o.desc = {"Defeat Vegeta and Goku."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 44;
			}

			if("Q009_THE_NAMEKIAN"){
				o.internal_name = "Q009_THE_NAMEKIAN"
				o.name = "The Namekian";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Piccolo)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Piccolo)" = 0);
				o.desc = {"Defeat Piccolo."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 45;
			}

			if("Q010_AN_EVIL_FORCE"){
				o.internal_name = "Q010_AN_EVIL_FORCE"
				o.name = "An Evil Force";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Frieza)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Frieza)" = 0);
				o.desc = {"Defeat Frieza."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 46;
			}

			if("Q011_DEADLY_DUO"){
				o.internal_name = "Q011_DEADLY_DUO"
				o.name = "The Deadly Duo";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Android17)" = 1,"hasKilled(/mob/NPA/earth/Android18)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Android17)" = 0,"hasKilled(/mob/NPA/earth/Android18)" = 0);
				o.desc = {"Defeat Android 17 and Android 18."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 47;
			}

			if("Q012_CELLS_MINIONS"){
				o.internal_name = "Q012_CELLS_MINIONS"
				o.name = "Cell's Minions";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/CellJr)" = 10);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/CellJr)" = 0);
				o.desc = {"Defeat Cell's minions."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 48;
			}

			if("Q013_BIO_MASSACRE"){
				o.internal_name = "Q013_BIO_MASSACRE"
				o.name = "Bio Massacre";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Imperfect_Cell)" = 1,"hasKilled(/mob/NPA/earth/Semi_Perfect_Cell)" = 1,"hasKilled(/mob/NPA/earth/Perfect_Cell)" = 1,"hasKilled(/mob/NPA/earth/Super_Perfect_Cell)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Imperfect_Cell)" = 0,"hasKilled(/mob/NPA/earth/Semi_Perfect_Cell)" = 0,"hasKilled(/mob/NPA/earth/Perfect_Cell)" = 0,"hasKilled(/mob/NPA/earth/Super_Perfect_Cell)" = 0);
				o.desc = {"Defeat Cell in all of his forms."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 49;
			}

			if("SQ006_PURIFICATION"){
				o.internal_name = "SQ006_PURIFICATION"
				o.name = "HFIL Subjugation";
				o.completedVariables = list("hasKilled(/mob/NPA/hfil/Demon)" = 5,"hasKilled(/mob/NPA/hfil/DemonKnight)" = 5,"hasKilled(/mob/NPA/hfil/Dabura)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/hfil/Demon)" = 0,"hasKilled(/mob/NPA/hfil/DemonKnight)" = 0,"hasKilled(/mob/NPA/hfil/Dabura)" = 0);
				o.desc = {"Establish your dominance!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(EVIL);
				o.internal_id = 19;
			}

			if("SAIYANQ001_THE_LEGEND"){
				o.internal_name = "SAIYANQ001_THE_LEGEND"
				o.name = "The Legend";
				o.completedVariables = list("hasSkill" = /Command/Technique/Form/ssj);
				o.savedVariables = NULL;
				o.desc = {"Not set."}
				o.allowedRaces = list(LEGENDARY_SAIYAN,SAIYAN)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 20;
			}

			if("G001_REACH_FOR_GODHOOD"){
				o.internal_name = "G001_REACH_FOR_GODHOOD"
				o.name = "Something wicked, this way comes";
				o.completedVariables = list("hasPower" = 7.50e+011);
				o.savedVariables = NULL
				o.desc = {"Your strength has been noticed."}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 21;
			}

			if("G002_CONFRONT_DESTRUCTION"){
				o.internal_name = "G002_CONFRONT_DESTRUCTION"
				o.name = "Battle of the Gods.";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Beerus)" = 5);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Beerus)" = 0);
				o.desc = {"Confront and defeat Beerus, God of Destruction!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 22;
			}

			if("G003_PATH_TO_ENLIGHTENMENT"){
				o.internal_name = "G003_PATH_TO_ENLIGHTENMENT"
				o.name = "Path to Enlightenment";
				o.completedVariables = list("hasPower" = 30.00e+011);
				o.savedVariables = NULL
				o.desc = {"Begin the path to Elightenment, reach {G3,000,000,000,000{x power level!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 23;
			}

			if("G004_ASCEND_OR_FALL"){
				o.internal_name = "G004_ASCEND_OR_FALL"
				o.name = "But a Whisper";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Whis)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Whis)" = 0);
				o.desc = {"Enter the Hyperbolic Time Chamber and defeat Whis!"}
				o.allowedRaces = list(ALL_RACES)
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 24;
			}

			if("S001_THE_LEGEND"){
				o.internal_name = "S001_THE_LEGEND";
				o.name = "The Legendary Saiyan Pt. 1";
				o.completedVariables = list("hasPower" = 30.00e+011);
				o.savedVariables = NULL;
				o.desc = {"Quest for the legendary powers of a super saiyan."}
				o.allowedRaces = list(SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 25;
			}

			if("S002_THE_LEGEND"){
				o.internal_name = "S002_THE_LEGEND";
				o.name = "The Legendary Saiyan Pt. 2";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Broly)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Broly)" = 0);
				o.desc = {"Quest for the legendary powers of a super saiyan. (NO TURNING BACK STATS AND SKILLS WILL RESET AND BE REBORN AS A LSSJ)"}
				o.allowedRaces = list(SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 26;
			}

			if("LS_01"){
				o.internal_name = "LS_01";
				o.name = "Dispatch the Guard!";
				o.completedVariables = list("hasKilled(/mob/NPA/vegeta/FriezaHenchman)" = 4);
				o.savedVariables = list("hasKilled(/mob/NPA/vegeta/FriezaHenchman)" = 0);
				o.desc = {"Defeat these vile scum on the homeworld!"}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 27;
			}

			if("LS_02"){
				o.internal_name = "LS_02";
				o.name = "Prepare the Saiyans!";
				o.completedVariables = list("hasKilled(/mob/NPA/vegeta/Treacherous_Saiyan)" = 2);
				o.savedVariables = list("hasKilled(/mob/NPA/vegeta/Treacherous_Saiyan)" = 0);
				o.desc = {"Prepare your fellow saiyans!"}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 28;
			}

			if("LS_03"){
				o.internal_name = "LS_03";
				o.name = "Reinforcements have arrived!";
				o.completedVariables = list("hasKilled(/mob/NPA/vegeta/Elite_Henchman)" = 5);
				o.savedVariables = list("hasKilled(/mob/NPA/vegeta/Elite_Henchman)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 29;
			}

			if("LS_04"){
				o.internal_name = "LS_04";
				o.name = "Become a Rebel!";
				o.completedVariables = list("hasKilled(/mob/NPA/vegeta/Shugesh)" = 1,"hasKilled(/mob/NPA/vegeta/Tora)" = 1,"hasKilled(/mob/NPA/vegeta/Fasha)" = 1,"hasKilled(/mob/NPA/vegeta/Borgos)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/vegeta/Shugesh)" = 0,"hasKilled(/mob/NPA/vegeta/Tora)" = 0,"hasKilled(/mob/NPA/vegeta/Fasha)" = 0,"hasKilled(/mob/NPA/vegeta/Borgos)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 30;
			}

			if("LS_05"){
				o.internal_name = "LS_05";
				o.name = "The King has summoned you!";
				o.completedVariables = list("hasKilled(/mob/NPA/vegeta/King_Vegeta)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/vegeta/King_Vegeta)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 31;
			}

			if("LS_06"){
				o.internal_name = "LS_06";
				o.name = "Travel to Namek!";
				o.completedVariables = list("Travel to Namek" = TRUE);
				o.savedVariables = list("Travel to Namek" = FALSE);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 32;
			}

			if("LS_07"){
				o.internal_name = "LS_07";
				o.name = "Find out what happened back home!";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Dodoria)" = 1,"hasKilled(/mob/NPA/namek/Zarbon)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Dodoria)" = 0,"hasKilled(/mob/NPA/namek/Zarbon)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 33;
			}

			if("LS_08"){
				o.internal_name = "LS_08";
				o.name = "Nail in the Coffin!";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Nail)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Nail)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 34;
			}

			if("LS_09"){
				o.internal_name = "LS_09";
				o.name = "Destroying the Ginyu Force";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Guldo)" = 1,"hasKilled(/mob/NPA/namek/Recoome)" = 1,"hasKilled(/mob/NPA/namek/Burter)" = 1,"hasKilled(/mob/NPA/namek/Jeice)" = 1,"hasKilled(/mob/NPA/namek/CaptainGinyu)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Guldo)" = 0,"hasKilled(/mob/NPA/namek/Recoome)" = 0,"hasKilled(/mob/NPA/namek/Burter)" = 0,"hasKilled(/mob/NPA/namek/Jeice)" = 0,"hasKilled(/mob/NPA/namek/CaptainGinyu)" = 0);
				o.desc = {"Defeat the Ginyu Force."}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 35;
			}

			if("LS_10"){
				o.internal_name = "LS_10";
				o.name = "The Prince of ALL saiyans";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Vegeta)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Vegeta)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 36;
			}

			if("LS_11"){
				o.internal_name = "LS_11";
				o.name = "Find Kakarot!";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Goku)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Goku)" = 0);
				o.desc = {"Locate Kakarot on Planet Namek and defeat him!"}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 37;
			}

			if("LS_12"){
				o.internal_name = "LS_12";
				o.name = "The planet's strongest!";
				o.completedVariables = list("hasKilled(/mob/NPA/namek/Piccolo)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/namek/Piccolo)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 38;
			}

			if("LS_13"){
				o.internal_name = "LS_13";
				o.name = "Bring Kakarot out of hiding";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Goten)" = 1,"hasKilled(/mob/NPA/earth/Kid_Trunks)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Goten)" = 0,"hasKilled(/mob/NPA/earth/Kid_Trunks)" = 0);
				o.desc = {"Travel to Earth and bring Kakarot out of hiding by slaying his son and Vegeta's son!"}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 39;
			}

			if("LS_14"){
				o.internal_name = "LS_14";
				o.name = "What does the future hold?";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/FriezaBot)" = 1,"hasKilled(/mob/NPA/earth/KingCold)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/FriezaBot)" = 0,"hasKilled(/mob/NPA/earth/KingCold)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 40;
			}

			if("LS_15"){
				o.internal_name = "LS_15";
				o.name = "Super Perfect Legendary Saiyan?";
				o.completedVariables = list("hasSkill" = /Command/Technique/Form/ssj2);
				o.savedVariables = NULL;
				o.desc = {"Become a Super Saiyan 2!"}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 41;
			}

			if("LS_16"){
				o.internal_name = "LS_16";
				o.name = "KAKAROT!!!!!!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Goku)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Goku)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 42;
			}

			if("LS_17"){
				o.internal_name = "LS_17";
				o.name = "I am Legend!";
				o.completedVariables = list("hasKilled(/mob/NPA/earth/Broly)" = 1);
				o.savedVariables = list("hasKilled(/mob/NPA/earth/Broly)" = 0);
				o.desc = {""}
				o.allowedRaces = list(LEGENDARY_SAIYAN);
				o.allowedAlign = list(GOOD,EVIL);
				o.internal_id = 43;
			}
		}

		return o;
	}