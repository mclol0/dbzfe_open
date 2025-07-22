mob
	NPA
		kaio_planet
			WarriorSpirit
				name = "Warrior Spirit"
				AGGRO = TRUE;
				race = SPIRIT
				sex = FEMALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				currpl = 7500
				maxpl = 7500
				randomRespawn = FALSE;
				teach = list("kaioken","gekiretsu")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut,
								/Command/Technique/Form/kaioken)
				dropList = list(/obj/item/ANGELIC_BREASTPLATE,/obj/item/WHITE_SPIRIT_GI,/obj/item/WHITE_SPIRIT_PANTS,
								/obj/item/HEAVENLY_HALO)

				visuals = list("skin_color" = "{WPale{x",
								"eye_color" = "{gGreen{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Ponytail",
								"hair_color" = "{YBlonde{x",
								"height" = "Average",
								"build" = "{MSkinny{x")


				New(){
					..()
					maxpl = rand(1200,2500)

					currpl = maxpl
				}


			KaioStudent
				name = "Kaio Student"
				AGGRO = TRUE;
				race = SPIRIT
				sex = FEMALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				currpl = 7500
				maxpl = 7500
				randomRespawn = FALSE;
				//teach = list("kaioken","gekiretsu")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut,
								/Command/Technique/Form/kaioken)
				dropList = list(/obj/item/ANGELIC_BREASTPLATE,/obj/item/WHITE_SPIRIT_GI,/obj/item/WHITE_SPIRIT_PANTS,
								/obj/item/HEAVENLY_HALO)

				visuals = list("skin_color" = "{WPale{x",
								"eye_color" = "{gGreen{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Ponytail",
								"hair_color" = "{YBlonde{x",
								"height" = "Average",
								"build" = "{MSkinny{x")


				New(){
					..()
					maxpl = rand(2500,5000)

					currpl = maxpl
				}

			KingKai
				name = "King Kai"
				race = SHINJIN
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = HARD
				curreng = 100
				maxeng = 100
				currpl = 12000
				maxpl = 12000
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)
				teach = list("spirit bomb","kaio heal");
				dropList = list(/obj/item/KING_KAIS_ANTENNA_HEADBAND)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Fat")

				death(mob/killer as mob, Command/tech){
					if(..(killer, tech)){

						var/planet/area = get_area("earth")

						if(area){
							killer.warpArea(rand(1,area.dx),rand(1,area.dy),area)

							send(buildMap(killer,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),killer);
							send("You have been warped back to [area.name]!",killer)
						}else{
							send("ERROR: Uh-oh something bad has happened!",killer)
						}
					}
				}