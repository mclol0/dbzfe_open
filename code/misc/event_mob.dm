var/eventMOB/event = new();

eventMOB

	var
		eventMobs = list("Broly","Lord Slug","Jiren","Golden Frieza","Zamasu","Gogeta","Lord Beerus","Whis");

		mob/NPA/EventMobRef = NULL;

		nextEventTime = NULL;
		endTime = NULL;

		started = FALSE;


	New(){
		..();

		nextEventTime = (world.time + 10 MINUTES);
		endTime = (world.time + 40 MINUTES);

		started = FALSE;

		start();
	}


	proc
		start(){
			set waitfor=FALSE;
			set background = TRUE;

			while(src){
				if(!EventMobRef){
					endTime = world.time;
				}

				if(!started && (world.time >= nextEventTime)){
					EventMobRef = decideMob();
					EventMobRef.start_event();
					started = TRUE;
					endTime = (world.time + 30 MINUTES);
				}else if(started && (world.time >= endTime)){
					if(EventMobRef && !EventMobRef.AI){
						send("{Y\[{x{GEVENT{x{Y\]{x [EventMobRef.raceColor(EventMobRef.name)] has despawned!",game.players,TRUE);
						del(EventMobRef);
					}

					started = FALSE;
					nextEventTime = (world.time + 60 MINUTES;);
				}

				sleep(world.tick_lag);
			}
		}

		decideMob(var/mob){

			mob = pick(eventMobs);

			var/mob/NPA/eventMob = new /mob/NPA;

			switch(mob){
				if("Golden Frieza"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Golden Frieza"
					eventMob.form = "GOLDEN FORM 4"
					eventMob.race = ICER
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 1250;
					eventMob.bonus_arm = 1250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX,/obj/item/GOLDEN_SCOUTER);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/eye_laser,
										/Command/Technique/tail_whip,
										/Command/Technique/zanzoken)
					eventMob.maxpl = 1.75e+012;
					eventMob.teach = list("goldform")
					eventMob.currpl = eventMob.getMaxPL();

					eventMob.visuals = list("skin_color" = "{WWhite{x",
									"eye_color" = "{RRed{x",
									"hair_length" = "None",
									"hair_style" = "Bald",
									"hair_color" = "None",
									"height" = "Short",
									"build" = "Toned")
				}
				if("Zamasu"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Zamasu"
					eventMob.form = "Mystic"
					eventMob.race = DIETY
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 1250;
					eventMob.bonus_arm = 1250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX,/obj/item/ZAMASUS_TIME_RING);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/eye_laser,
										/Command/Technique/fury,
										/Command/Technique/zanzoken)

					eventMob.maxpl = 855.00e+012;
					eventMob.currpl = eventMob.getMaxPL();
					eventMob.teach = list("ssjb", "ssjr")


					eventMob.visuals = list("skin_color" = "{GGreen{x",
									"eye_color" = "{wGrey{x",
									"hair_length" = "Short",
									"hair_style" = "Spiked",
									"hair_color" = "{WWhite{x",
									"height" = "Average",
									"build" = "Toned")
				}

				if("Whis"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Whis"
					eventMob.form = "Mystic"
					eventMob.race = DIETY
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 2150;
					eventMob.bonus_arm = 1650;
					eventMob.dropList.Add(/obj/item/EVENT_BOX);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/eye_laser,
										/Command/Technique/fury,
										/Command/Technique/zanzoken)

					eventMob.maxpl = 1055.00e+012;
					eventMob.currpl = eventMob.getMaxPL();
					//eventMob.teach = list("ssjb", "ssjr")


					eventMob.visuals = list("skin_color" = "{CPale Blue{x",
									"eye_color" = "{MViolet{x",
									"hair_length" = "Short",
									"hair_style" = "Spiked",
									"hair_color" = "{WWhite{x",
									"height" = "Tall",
									"build" = "Skinny")
				}

				if("Lord Beerus"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Lord Beerus"
					eventMob.form = "Mystic"
					eventMob.race = DIETY
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 1850;
					eventMob.bonus_arm = 1250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/eye_laser,
										/Command/Technique/fury,
										/Command/Technique/zanzoken)

					eventMob.maxpl = 955.00e+012;
					eventMob.currpl = eventMob.getMaxPL();
					//eventMob.teach = list("ssjb", "ssjr")


					eventMob.visuals = list("skin_color" = "{mPurple{x",
									"eye_color" = "{YYellow{x",
									"hair_length" = "Bald",
									"hair_style" = "Bunny Ears",
									"hair_color" = "None",
									"height" = "Tall",
									"build" = "Skinny")
				}
				if("Lord Slug"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Lord Slug"
					eventMob.form = "Super Namek"
					eventMob.race = NAMEK
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 1250;
					eventMob.bonus_arm = 1250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/specialbeamcannon,
										/Command/Technique/eye_laser)
					eventMob.maxpl = 855.00e+012;
					eventMob.currpl = eventMob.getMaxPL();

					eventMob.visuals = list("skin_color" = "{gDark Green{x",
									"eye_color" = "{RRed{x",
									"hair_length" = "None",
									"hair_style" = "Antennae",
									"hair_color" = "None",
									"height" = "Giant",
									"build" = "Muscular")
				}

				if("Broly"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Broly"
					eventMob.form = "Legendary SSJ2"
					eventMob.race = SAIYAN
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 1250;
					eventMob.bonus_arm = 1250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX,/obj/item/BROLYS_EARRINGS);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/final_flash,
										/Command/Technique/erasercannon)
					eventMob.maxpl = 855.00e+012;
					eventMob.currpl = eventMob.getMaxPL();

					eventMob.visuals = list("skin_color" = "{yTan{x",
									"eye_color" = "{DBlack{x",
									"hair_length" = "Short",
									"hair_style" = "Spiked",
									"hair_color" = "{DBlack{x",
									"height" = "Tall",
									"build" = "Muscular")
				}

				if("Gogeta"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Gogeta"
					eventMob.form = "Super Saiyan 4"
					eventMob.race = SAIYAN
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = GOOD
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 2250;
					eventMob.bonus_arm = 2250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX,/obj/item/GOGETAS_SASH);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/final_flash,
										/Command/Technique/erasercannon,
										/Command/Technique/super_kamehameha)
					eventMob.maxpl = 855.00e+012;
					eventMob.currpl = eventMob.getMaxPL();
					eventMob.teach = list("ssj4")

					eventMob.visuals = list("skin_color" = "{yTan{x",
									"eye_color" = "{CCyan{x",
									"hair_length" = "Short",
									"hair_style" = "Spiked",
									"hair_color" = "{RRed{x",
									"height" = "Average",
									"build" = "Toned")
				}

				if("Jiren"){
					eventMob.respawn = FALSE;
					eventMob.sex = MALE;
					eventMob.name = "Jiren"
					eventMob.form = "Enhanced"
					eventMob.race = ALIEN
					eventMob.hostile = TRUE
					eventMob.AGGRO = TRUE
					eventMob.alignment = EVIL
					eventMob.difficultyLevel = EVENT_MOB;
					eventMob.curreng = 500
					eventMob.maxeng = 500
					eventMob.bonus_str = 1250;
					eventMob.bonus_arm = 1250;
					eventMob.dropList.Add(/obj/item/EVENT_BOX,/obj/item/JIRENS_GLOVES,/obj/item/JIRENS_BOOTS);
					eventMob.techniques.Add(/Command/Technique/fly,
										/Command/Technique/punch,
										/Command/Technique/roundhouse,
										/Command/Technique/sweep,
										/Command/Technique/parry,
										/Command/Technique/jump,
										/Command/Technique/duck,
										/Command/Technique/dodge,
										/Command/Technique/power,
										/Command/Technique/snapneck,
										/Command/Technique/deflect,
										/Command/Technique/onslaught,
										/Command/Technique/revert,
										/Command/Technique/elbow,
										/Command/Technique/blast,
										/Command/Technique/final_flash,
										/Command/Technique/erasercannon)
					eventMob.maxpl = 355.00e+012;
					eventMob.currpl = eventMob.getMaxPL();
					eventMob.teach = list("ultrainstinct")

					eventMob.visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Average",
								"build" = "Muscular")
				}
			}

			return eventMob;
		}
