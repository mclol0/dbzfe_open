mob
	NPA
		hfil
			Dabura
				name = "Dabura"
				race = DEMON
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				randomRespawn = FALSE
				difficultyLevel = HARD
				curreng = 100
				maxeng = 100
				currpl = 12000
				maxpl = 12000
				teach = list("stonespit")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)

				visuals = list("skin_color" = "{RRed{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Horns",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

				death(mob/killer as mob, Command/tech){
					if(..(killer, tech)){
						if(killer.alignment == GOOD || killer.race == KAIO && killer.maxpl > 20000){
							killer.loc=locate(97,4,4); // spawn at the begining of snakeway
							send(buildMap(killer,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),killer);
						}
					}
				}

			Demon
				name = "Demon"
				AGGRO = TRUE;
				race = DEMON
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				teach = list("flameslash")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast)
				dropList = list(/obj/item/BLUE_DEMON_GI,/obj/item/BLUE_DEMON_PANTS,/obj/item/HFILFIRE_HORNS)

				visuals = list("skin_color" = "{RRed{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "{WHorns{x",
								"hair_color" = "{DBlack{x",
								"height" = "Tall",
								"build" = "{RToned{x")

				New(){
					..()

					maxpl = rand(1200,2500)

					currpl = maxpl
				}

			DemonKnight
				name = "Demon Knight"
				AGGRO = FALSE;
				race = DEMON
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				teach = list("hellfirelance")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast,/Command/Technique/hammer, /Command/Technique/uppercut)
				dropList = list(/obj/item/DEMONIC_BREASTPLATE,/obj/item/METAL_ARMPLATE,/obj/item/CRIMSON_HFIL_EARRING,/obj/item/HFILFIRE_HORNS)

				visuals = list("skin_color" = "{RRed{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "{WHorns{x",
								"hair_color" = "{DBlack{x",
								"height" = "Tall",
								"build" = "{RToned{x")

				New(){
					..()

					maxpl = rand(3000,7000)

					currpl = maxpl
				}