mob
	NPA
		snakeway
			Spirit
				name = "Spirit"
				AGGRO = TRUE;
				race = SPIRIT
				sex = UNKNOWN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast)
				dropList = list(/obj/item/HEAVENLY_HALO,/obj/item/WHITE_SPIRIT_GI,/obj/item/WHITE_SPIRIT_PANTS)

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "None",
								"hair_length" = "None",
								"hair_style" = "None",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "{MFluffy{x")


				New(){
					..()

					maxpl = rand(1200,2400)

					currpl = maxpl
				}

			Princess_Snake
				name = "Princess Snake"
				AGGRO = TRUE;
				race = SPIRIT
				sex = FEMALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				currpl = 6500
				maxpl = 6500
				dropList = list(/obj/item/SNAKESKIN_SLEEVES,/obj/item/PRINCESS_SNAKE_EARRINGS)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{ROrange{x",
								"height" = "Average",
								"build" = "{MSkinny{x")

				New(){
					..()
				}

			SnakeHandmaiden
				name = "Snake Handmaiden"
				AGGRO = FALSE;
				race = SPIRIT
				sex = FEMALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				dropList = list(/obj/item/SNAKESKIN_SLEEVES,/obj/item/PRINCESS_SNAKE_EARRINGS)
				alliedType = list(/mob/NPA/snakeway/Princess_Snake,/mob/NPA/snakeway/SnakeHandmaiden)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{ROrange{x",
								"height" = "Average",
								"build" = "{MSkinny{x")

				New(){
					..()

					maxpl = rand(4000,5000)

					currpl = maxpl
				}